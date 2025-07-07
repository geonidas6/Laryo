<?php

namespace Database\Seeders;

use App\Models\UiTemplate;
use Illuminate\Database\Seeder;

class UiTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        UiTemplate::create([
            'key' => 'main_layout',
            'value' => '<div>Main Layout</div>',
            'type' => 'html',
        ]);
    }
}
