<?php

namespace App\Console\Commands;

use App\Models\Event;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;

class SendEventReminders extends Command
{
    protected $signature = 'events:send-reminders';

    protected $description = 'Send FCM reminders for events starting tomorrow';

    public function handle(): void
    {
        $tomorrow = now()->addDay()->startOfDay();
        $events = Event::whereDate('start_at', $tomorrow)->with('users')->get();

        foreach ($events as $event) {
            foreach ($event->users as $user) {
                if (! $user->fcm_token) {
                    continue;
                }

                Http::withToken(config('services.fcm.server_key'))
                    ->post('https://fcm.googleapis.com/fcm/send', [
                        'to' => $user->fcm_token,
                        'notification' => [
                            'title' => 'Event Reminder',
                            'body' => "{$event->title} is tomorrow",
                        ],
                    ]);
            }
        }
    }
}
