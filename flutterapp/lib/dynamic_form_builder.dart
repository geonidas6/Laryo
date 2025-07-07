import 'package:flutter/material.dart';

class DynamicFormBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> fields;
  final void Function(Map<String, dynamic> values) onSubmit;

  const DynamicFormBuilder({
    Key? key,
    required this.fields,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<DynamicFormBuilder> createState() => _DynamicFormBuilderState();
}

class _DynamicFormBuilderState extends State<DynamicFormBuilder> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _values = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...widget.fields.map((field) {
            final label = field['label'] as String? ?? '';
            final type = field['type'] as String? ?? 'text';
            final requiredField = field['required'] == true;
            if (type == 'checkbox') {
              _values[label] = _values[label] ?? false;
              return CheckboxListTile(
                title: Text(label),
                value: _values[label] as bool,
                onChanged: (v) => setState(() => _values[label] = v),
              );
            }
            return TextFormField(
              decoration: InputDecoration(labelText: label),
              keyboardType: type == 'number' ? TextInputType.number : null,
              validator: requiredField
                  ? (v) => v == null || v.isEmpty ? 'Required' : null
                  : null,
              onSaved: (v) => _values[label] = v,
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSubmit(_values);
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
