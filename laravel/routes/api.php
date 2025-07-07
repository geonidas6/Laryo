<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SSOController;

Route::get('/sso/redirect/{provider}', [SSOController::class, 'redirect']);
Route::get('/sso/callback/{provider}', [SSOController::class, 'callback']);
