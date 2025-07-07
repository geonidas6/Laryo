<?php

use App\Models\User;
use Laravel\Sanctum\Sanctum;
use App\Models\Record;

it('stores records from sync endpoint', function () {
    $user = User::factory()->create();

    Sanctum::actingAs($user);

    $payload = [
        'records' => [
            ['foo' => 'bar'],
            ['baz' => 123],
        ],
    ];

    $response = $this->postJson('/api/sync', $payload);

    $response->assertOk()->assertJson(['status' => 'synced']);

    expect(Record::count())->toBe(2);
});
