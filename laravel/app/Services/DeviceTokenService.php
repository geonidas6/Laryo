<?php

namespace App\Services;

use App\Models\DeviceToken;
use App\Models\User;

class DeviceTokenService
{
    public function store(User $user, string $token): DeviceToken
    {
        return DeviceToken::updateOrCreate(
            ['token' => $token],
            ['user_id' => $user->id]
        );
    }
}
