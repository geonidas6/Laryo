<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Event;
use Illuminate\Http\Request;

class EventController extends Controller
{
    public function index(Request $request)
    {
        $events = $request->user()->events()->with('reminders')->get();
        return response()->json($events);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'start_at' => ['required', 'date'],
            'end_at' => ['nullable', 'date', 'after_or_equal:start_at'],
        ]);

        $event = Event::create($request->only('title', 'description', 'start_at', 'end_at'));
        $event->users()->attach($request->user());

        // create J-1 reminder
        $event->reminders()->create([
            'remind_at' => \Carbon\Carbon::parse($request->start_at)->subDay(),
        ]);

        return response()->json($event->load('reminders'), 201);
    }
}
