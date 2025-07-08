<?php


use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SSOController;


use App\Http\Requests\Auth\LoginRequest;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\FeatureController;
use App\Http\Controllers\UiTemplateController;
use Illuminate\Support\Facades\Route;

Route::get('/ui-template', [UiTemplateController::class, 'index']);
Route::get('/features', [FeatureController::class, 'index']);

Route::get('/sso/redirect/{provider}', [SSOController::class, 'redirect']);
Route::get('/sso/callback/{provider}', [SSOController::class, 'callback']);


Route::post('/login', function (LoginRequest $request) {
    $request->authenticate();
    $user = $request->user();
    $token = $user->createToken('api-token')->plainTextToken;
    return response()->json(['token' => $token, 'user' => $user]);
});

Route::post('/register', function (Request $request) {
    $attributes = $request->validate([
        'name' => ['required', 'string', 'max:255'],
        'email' => ['required', 'string', 'email', 'max:255', 'unique:'.User::class],
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

