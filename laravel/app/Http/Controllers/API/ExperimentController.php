<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Experiment;
use App\Models\ExperimentAssignment;
use Illuminate\Http\Request;

class ExperimentController extends Controller
{
    public function assignments(Request $request)
    {
        $user = $request->user();
        $results = [];

        foreach (Experiment::all() as $experiment) {
            $assignment = ExperimentAssignment::firstOrCreate(
                ['user_id' => $user->id, 'experiment_id' => $experiment->id],
                ['variant' => collect($experiment->variants)->random()]
            );

            $results[$experiment->key] = $assignment->variant;
        }

        return response()->json($results);
    }
}
