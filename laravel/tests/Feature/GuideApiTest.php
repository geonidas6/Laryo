<?php

use App\Models\Guide;
use App\Models\GuideStep;

it('returns active guides with steps', function () {
    $guide = Guide::create(['name' => 'Test Guide']);
    GuideStep::create([
        'guide_id' => $guide->id,
        'title' => 'Step 1',
        'content' => 'Content',
        'step_order' => 1,
    ]);

    $response = $this->getJson('/api/guides');

    $response->assertOk()->assertJsonFragment(['name' => 'Test Guide'])
             ->assertJsonFragment(['title' => 'Step 1']);
});
