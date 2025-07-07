<?php

namespace App\Services;

use App\Notifications\FcmNotification;
use Illuminate\Support\Facades\Notification;

class FcmService
{
    public function sendToToken(string $token, string $title, string $body): void
    {
        Notification::route('fcm', $token)
            ->notify(new FcmNotification($title, $body));
    }
}
