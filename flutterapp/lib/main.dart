import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/auth_service.dart';
import 'services/api_service.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'plugins/plugin_registry.dart';
import 'plugins/example_plugin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  registerExamplePlugin();
  final auth = AuthService();
  final token = await auth.getToken();
  final api = ApiService();
  final enabled = await api.getEnabledPlugins();
  PluginRegistry.enablePlugins(enabled);
  runApp(MyApp(initialToken: token));
}

class MyApp extends StatelessWidget {
  final String? initialToken;
  const MyApp({super.key, this.initialToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: PluginRegistry.routes,
      home: initialToken == null ? const LoginScreen() : const ProfileScreen(),
    );
  }
}
