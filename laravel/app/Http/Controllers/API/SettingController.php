<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\UserSetting;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    public function index(Request $request)
    {
        $settings = $request->user()->settings()->pluck('value', 'key');
        return response()->json($settings);
    }

    public function update(Request $request, string $key)
    {
        $request->validate(['value' => ['nullable', 'string']]);
        $setting = UserSetting::updateOrCreate(
            ['user_id' => $request->user()->id, 'key' => $key],
            ['value' => $request->input('value')]
        );
        return response()->json($setting);
    }
}
