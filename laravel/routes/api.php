<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserProfileController;

Route::middleware('auth')->group(function () {
    Route::get('/profile', [UserProfileController::class, 'show']);
    Route::post('/profile', [UserProfileController::class, 'store']);
    Route::patch('/profile', [UserProfileController::class, 'update']);
    Route::delete('/profile', [UserProfileController::class, 'destroy']);
});
