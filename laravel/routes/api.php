<?php

use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Route;

Route::get('/translations/{locale}', function (string $locale) {
    $path = lang_path("$locale/messages.php");

    if (!File::exists($path)) {
        abort(404);
    }

    return response()->json(require $path);
});
