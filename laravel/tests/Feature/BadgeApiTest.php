<?php

use App\Models\Badge;
use App\Models\User;
use Laravel\Sanctum\Sanctum;

it('lists all badges', function () {
    Badge::factory()->count(2)->create();
    $response = $this->getJson('/api/badges');
    $response->assertOk()->assertJsonCount(2);
});

it('lists user badges', function () {
    $user = User::factory()->create();
    $badge = Badge::factory()->create();
    $user->badges()->attach($badge->id);

    Sanctum::actingAs($user);
    $response = $this->getJson('/api/user/badges');
    $response->assertOk()->assertJsonCount(1);
});

