import 'package:flutter/widgets.dart';

class Plugin {
  final String name;
  final WidgetBuilder builder;
  const Plugin(this.name, this.builder);
}

class PluginRegistry {
  static final Map<String, Plugin> _available = {};
  static final Map<String, Plugin> _enabled = {};

  static void registerAvailable(Plugin plugin) {
    _available[plugin.name] = plugin;
  }

  static void enablePlugins(Iterable<String> names) {
    _enabled
      ..clear();
    for (final name in names) {
      final plugin = _available[name];
      if (plugin != null) {
        _enabled[name] = plugin;
      }
    }
  }

  static Map<String, WidgetBuilder> get routes => {
        for (final plugin in _enabled.values) '/${plugin.name}': plugin.builder,
      };
}
