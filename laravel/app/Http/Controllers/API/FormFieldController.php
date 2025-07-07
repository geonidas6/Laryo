<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Form;
use App\Models\FormField;
use Illuminate\Http\Request;

class FormFieldController extends Controller
{
    public function index(Form $form)
    {
        return $form->fields;
    }

    public function store(Request $request, Form $form)
    {
        $data = $request->validate([
            'label' => 'required|string|max:255',
            'type' => 'required|string|max:50',
            'required' => 'boolean',
        ]);

        $field = $form->fields()->create($data);

        return response()->json($field, 201);
    }

    public function show(FormField $field)
    {
        return $field;
    }

    public function update(Request $request, FormField $field)
    {
        $data = $request->validate([
            'label' => 'sometimes|required|string|max:255',
            'type' => 'sometimes|required|string|max:50',
            'required' => 'boolean',
        ]);

        $field->update($data);

        return response()->json($field);
    }

    public function destroy(FormField $field)
    {
        $field->delete();

        return response()->json(null, 204);
    }
}
