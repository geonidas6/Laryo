<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Record;
use Illuminate\Http\Request;

class SyncController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'records' => 'required|array',
        ]);

        $user = $request->user();

        foreach ($request->input('records') as $record) {
            Record::create([
                'user_id' => $user->id,
                'data' => $record,
            ]);
        }

        return response()->json(['status' => 'synced']);
    }
}
