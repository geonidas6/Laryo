<?php

use Illuminate\Support\Facades\Route;

Route::get('/plugins', function () {
    $path = base_path('plugins.json');
    $enabled = [];
    if (file_exists($path)) {
        $data = json_decode(file_get_contents($path), true);
        if (is_array($data)) {
            $enabled = array_keys(array_filter($data));
        }
    }
    return ['plugins' => $enabled];
});
