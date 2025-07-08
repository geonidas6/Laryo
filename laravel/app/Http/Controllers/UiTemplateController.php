<?php

namespace App\Http\Controllers;

use App\Models\UiTemplate;
use Illuminate\Http\JsonResponse;

class UiTemplateController extends Controller
{
    /**
     * Display a listing of UI templates.
     */
    public function index(): JsonResponse
    {
        return response()->json(UiTemplate::all());
    }
}
