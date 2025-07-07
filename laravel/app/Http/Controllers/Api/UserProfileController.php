<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\UserProfile;

class UserProfileController extends Controller
{
    public function show(Request $request): JsonResponse
    {
        $profile = $request->user()->profile;
        return response()->json($profile);
    }

    public function store(Request $request): JsonResponse
    {
        $data = $request->validate([
            'avatar_url' => ['nullable', 'string'],
            'bio' => ['nullable', 'string'],
            'language' => ['nullable', 'string', 'max:10'],
        ]);

        $profile = $request->user()->profile()->create($data);
        return response()->json($profile, 201);
    }

    public function update(Request $request): JsonResponse
    {
        $data = $request->validate([
            'avatar_url' => ['nullable', 'string'],
            'bio' => ['nullable', 'string'],
            'language' => ['nullable', 'string', 'max:10'],
        ]);

        $profile = $request->user()->profile;
        $profile->update($data);
        return response()->json($profile);
    }

    public function destroy(Request $request): JsonResponse
    {
        $profile = $request->user()->profile;
        $profile->delete();
        return response()->json(null, 204);
    }
}
