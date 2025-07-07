<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Form;
use Illuminate\Http\Request;

class FormController extends Controller
{
    public function index()
    {
        return Form::with('fields')->get();
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $form = Form::create($data);

        return response()->json($form, 201);
    }

    public function show(Form $form)
    {
        return $form->load('fields');
    }

    public function update(Request $request, Form $form)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $form->update($data);

        return response()->json($form);
    }

    public function destroy(Form $form)
    {
        $form->delete();

        return response()->json(null, 204);
    }
}
