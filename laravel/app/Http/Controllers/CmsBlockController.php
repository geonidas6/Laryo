<?php

namespace App\Http\Controllers;

use App\Models\CmsBlock;
use Illuminate\Http\JsonResponse;

class CmsBlockController extends Controller
{
    public function show(string $key): JsonResponse
    {
        $block = CmsBlock::where('key', $key)->firstOrFail();
        return response()->json($block);
    }
}
