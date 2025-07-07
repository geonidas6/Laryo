<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';

Route::post('/api/analytics', function (\Illuminate\Http\Request $request) {
    \App\Models\Analytics::create([
        'page' => $request->input('page', $request->path()),
        'user_id' => $request->user()?->id,
    ]);

    return response()->noContent();
})->name('analytics.store');

Route::get('/analytics', function () {
    $analytics = \App\Models\Analytics::latest()->paginate(50);
    return view('analytics.index', compact('analytics'));
})->middleware(['auth', 'verified'])->name('analytics.index');
