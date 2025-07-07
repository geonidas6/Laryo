<?php

use App\Http\Controllers\CmsBlockController;
use Illuminate\Support\Facades\Route;

Route::get('/blocks/{key}', [CmsBlockController::class, 'show']);
