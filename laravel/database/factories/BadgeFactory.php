<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\Badge>
 */
class BadgeFactory extends Factory
{
    protected $model = \App\Models\Badge::class;

    public function definition(): array
    {
        return [
            'name' => $this->faker->word(),
            'description' => $this->faker->sentence(),
            'xp_threshold' => $this->faker->numberBetween(0, 100),
        ];
    }
}
