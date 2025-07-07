<?php

namespace App\Http\Middleware;

use App\Models\Analytics;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RecordPageView
{
    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        try {
            Analytics::create([
                'page' => $request->path(),
                'user_id' => $request->user()?->id,
            ]);
        } catch (\Throwable $e) {
            // Logging can be added here if needed
        }

        return $response;
    }
}
