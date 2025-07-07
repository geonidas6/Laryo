<?php

use App\Http\Controllers\FeatureController;
use App\Http\Controllers\UiTemplateController;
use Illuminate\Support\Facades\Route;

Route::get('/ui-template', [UiTemplateController::class, 'index']);
Route::get('/features', [FeatureController::class, 'index']);
