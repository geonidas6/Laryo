<?php

use App\Models\User;

// Registration

test('api register creates new user', function () {
    $response = $this->postJson('/api/register', [
        'name' => 'Test User',
        'email' => 'test@example.com',
        'password' => 'password',
    ]);
    $response->assertCreated();
});

test('api register rejects invalid data', function () {
    $response = $this->postJson('/api/register', []);
    $response->assertStatus(422);
});

// Login

test('api login returns token', function () {
    $user = User::factory()->create([
        'email' => 'login@example.com',
        'password' => bcrypt('password'),
    ]);

    $response = $this->postJson('/api/login', [
        'email' => 'login@example.com',
        'password' => 'password',
    ]);

    $response->assertOk();
});

test('api login fails with invalid credentials', function () {
    $response = $this->postJson('/api/login', [
        'email' => 'wrong@example.com',
        'password' => 'invalid',
    ]);

    $response->assertUnauthorized();
});

// Profile

test('api profile requires authentication', function () {
    $response = $this->getJson('/api/profile');
    $response->assertUnauthorized();
});

test('api profile returns user info', function () {
    $user = User::factory()->create();
    $response = $this->actingAs($user)->getJson('/api/profile');
    $response->assertOk();
});

// Features

test('api features returns data', function () {
    $response = $this->getJson('/api/features');
    $response->assertOk();
});

test('api ui-template returns data', function () {
    $response = $this->getJson('/api/ui-template');
    $response->assertOk();
});
