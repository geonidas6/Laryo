<?php

use App\Http\Requests\Auth\LoginRequest;
use App\Http\Controllers\API\FormController;
use App\Http\Controllers\API\FormFieldController;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
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

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/profile', function (Request $request) {
        return response()->json(['user' => $request->user()]);
    });

    Route::post('/logout', function (Request $request) {
        $request->user()->currentAccessToken()->delete();
        return response()->json([], 204);
    });

    Route::apiResource('forms', FormController::class);
    Route::apiResource('forms.fields', FormFieldController::class)->shallow();
});
