<?php

namespace App\Http\Controllers;

use App\Models\Feature;
use Illuminate\Http\JsonResponse;

class FeatureController extends Controller
{
    /**
     * Display a listing of features.
     */
    public function index(): JsonResponse
    {
        return response()->json(Feature::all());
    }
}
