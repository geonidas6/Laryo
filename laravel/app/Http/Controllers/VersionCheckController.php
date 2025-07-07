<?php

namespace App\Http\Controllers;

use App\Models\AppVersion;
use Illuminate\Http\Request;

class VersionCheckController extends Controller
{
    public function __invoke(Request $request)
    {
        $data = $request->validate([
            'platform' => 'required|string',
            'version' => 'required|string',
        ]);

        $appVersion = AppVersion::where('platform', $data['platform'])->first();

        if (! $appVersion) {
            return response()->json(['message' => 'Platform not found'], 404);
        }

        $updateRequired = version_compare($data['version'], $appVersion->current_version, '<');
        $forceUpdate = $appVersion->force_update ||
            version_compare($data['version'], $appVersion->min_version, '<');

        return response()->json([
            'update_required' => $updateRequired,
            'force_update' => $forceUpdate,
            'current_version' => $appVersion->current_version,
            'min_version' => $appVersion->min_version,
            'changelog' => $appVersion->changelog,
        ]);
    }
}
