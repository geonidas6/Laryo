<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreDeviceTokenRequest;
use App\Services\DeviceTokenService;
use Illuminate\Http\JsonResponse;

class DeviceTokenController extends Controller
{
    public function __construct(private readonly DeviceTokenService $service)
    {
    }

    public function store(StoreDeviceTokenRequest $request): JsonResponse
    {
        $this->service->store($request->user(), $request->validated('token'));

        return response()->json(['status' => 'ok']);
    }
}
