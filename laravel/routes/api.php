<?php

use App\Http\Controllers\MediaController;
use App\Http\Requests\Auth\LoginRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;

Route::post('/login', function (LoginRequest $request) {
    $request->authenticate();
    $user = $request->user();
    $token = $user->createToken('api-token')->plainTextToken;
    return response()->json(['token' => $token, 'user' => $user]);
});

Route::post('/register', function (Request $request) {
    $attributes = $request->validate([
        'name' => ['required', 'string', 'max:255'],
        'email' => ['required', 'string', 'email', 'max:255', 'unique:' . User::class],
        'password' => ['required', 'string', 'confirmed'],
    ]);

    $user = User::create([
        'name' => $attributes['name'],
        'email' => $attributes['email'],
        'password' => Hash::make($attributes['password']),
    ]);

    $token = $user->createToken('api-token')->plainTextToken;

    return response()->json(['token' => $token, 'user' => $user], 201);
});

Route::middleware('auth:sanctum')->get('/profile', function (Request $request) {
    return response()->json(['user' => $request->user()]);
});

Route::middleware('auth:sanctum')->post('/logout', function (Request $request) {
    $request->user()->currentAccessToken()->delete();
    return response()->json([], 204);
});

Route::middleware('auth:sanctum')->post('/media', [MediaController::class, 'store']);
Route::get('/media/{media}', [MediaController::class, 'show']);
