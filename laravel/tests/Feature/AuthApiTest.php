<?php

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\Sanctum;

it('registers a user via the API', function () {
    $payload = [
        'name' => 'John Doe',
        'email' => 'john@example.com',
        'password' => 'password',
        'password_confirmation' => 'password',
    ];

    $response = $this->postJson('/api/register', $payload);

    $response->assertCreated()->assertJsonStructure([
        'token',
        'user' => [
            'id',
            'name',
            'email',
            'created_at',
            'updated_at',
        ],
    ]);

    expect(User::where('email', 'john@example.com')->exists())->toBeTrue();
});

it('logs in via the API and returns a token', function () {
    $user = User::factory()->create([
        'email' => 'john@example.com',
        'password' => Hash::make('password'),
    ]);

    $response = $this->postJson('/api/login', [
        'email' => 'john@example.com',
        'password' => 'password',
    ]);

    $response->assertOk()->assertJsonStructure([
        'token',
        'user' => [
            'id',
            'name',
            'email',
            'created_at',
            'updated_at',
        ],
    ]);
});

it('retrieves the authenticated user\'s profile via the API', function () {
    $user = User::factory()->create();

    Sanctum::actingAs($user);

    $response = $this->getJson('/api/profile');

    $response->assertOk()->assertJsonStructure([
        'id',
        'name',
        'email',
        'created_at',
        'updated_at',
    ]);
});
