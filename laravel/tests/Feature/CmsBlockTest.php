<?php

use App\Models\CmsBlock;

it('returns block by key', function () {
    CmsBlock::create([
        'key' => 'welcome',
        'type' => 'text',
        'value' => 'Hello world',
    ]);

    $response = $this->getJson('/api/blocks/welcome');

    $response->assertOk();
    $response->assertJson([
        'key' => 'welcome',
        'type' => 'text',
        'value' => 'Hello world',
    ]);
});
