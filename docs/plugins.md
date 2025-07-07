# Plugin System

This project allows modules to be enabled or disabled dynamically using a `plugins.json` file for Laravel and the corresponding configuration in the Flutter app.

## Laravel Plugins

1. Define enabled modules in `laravel/plugins.json`:
   ```json
   {
     "example": true
   }
   ```
2. Each plugin lives inside `laravel/modules/<name>` with a `routes.php` file and optional `permissions.php` returning an array of permission strings.
3. The `PluginServiceProvider` reads `plugins.json` and automatically loads routes and creates permissions for enabled plugins.
4. The list of enabled plugins is exposed via the `/api/plugins` endpoint for the Flutter app.

## Flutter Plugins

1. Plugins register a route via `PluginRegistry.registerAvailable` in `lib/plugins`.
2. At startup the app calls the API to obtain enabled plugins and activates them using `PluginRegistry.enablePlugins`.
3. Enabled plugin routes are added to `MaterialApp.routes`.

## Creating a New Plugin

1. **Laravel**
   - Create `laravel/modules/<your_plugin>/routes.php` and optionally `permissions.php`.
   - Add the plugin name to `laravel/plugins.json` and set it to `true`.
2. **Flutter**
   - Create a Dart file under `flutterapp/lib/plugins` exporting a `register` function that calls `PluginRegistry.registerAvailable` with a `WidgetBuilder`.
   - Import and invoke the register function in `main.dart`.
3. Restart the backend and Flutter app. The plugin will be available when enabled in `plugins.json`.
