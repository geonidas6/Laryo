<?php

namespace Database\Seeders;

use App\Models\Feature;
use Illuminate\Database\Seeder;

class FeatureSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Feature::create([
            'key' => 'dark_mode',
            'enabled' => true,
            'description' => 'Enable dark theme for users',
        ]);
    }
}
