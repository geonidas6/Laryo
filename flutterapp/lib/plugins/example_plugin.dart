import 'package:flutter/material.dart';
import 'plugin_registry.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Plugin')),
      body: const Center(child: Text('Example plugin screen')),
    );
  }
}

void registerExamplePlugin() {
  PluginRegistry.registerAvailable(
    const Plugin('example', (context) => ExampleScreen()),
  );
}
