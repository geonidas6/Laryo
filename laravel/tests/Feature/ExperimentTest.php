<?php

use App\Models\Experiment;
use App\Models\ExperimentAssignment;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\Sanctum;

it('assigns a variant on first call', function () {
    $user = User::factory()->create();
    $experiment = Experiment::create([
        'key' => 'welcome_message',
        'variants' => ['control', 'new'],
    ]);

    Sanctum::actingAs($user);

    $response = $this->getJson('/api/experiments');

    $response->assertOk()->assertJsonStructure([
        'welcome_message',
    ]);

    $variant = ExperimentAssignment::where('user_id', $user->id)->first();
    expect($variant)->not->toBeNull();
});
