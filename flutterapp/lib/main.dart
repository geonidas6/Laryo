import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/secure_auth_service.dart';
import 'services/settings_service.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final auth = SecureAuthService();
  final token = await auth.getToken();
  runApp(MyApp(initialToken: token));
}

class MyApp extends StatefulWidget {
  final String? initialToken;
  const MyApp({super.key, this.initialToken});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final service = SettingsService();
    final settings = await service.loadSettings();
    setState(() {
      _darkMode = settings['darkMode'] == 'true' || settings['darkMode'] == true;
    });
  }

  void _updateTheme(bool dark) {
    setState(() {
      _darkMode = dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = _darkMode ? ThemeData.dark() : ThemeData.light();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: widget.initialToken == null
          ? LoginScreen(onThemeChanged: _updateTheme)
          : ProfileScreen(onThemeChanged: _updateTheme),
    );
  }
}
