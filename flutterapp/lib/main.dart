import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/auth_service.dart';
import 'services/feature_manager_service.dart';
import 'services/template_service.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final auth = AuthService();

  await Future.wait([
    featureManager.loadFeatures(),
    templateService.loadTemplate(),
  ]);

  final token = await auth.getToken();
  runApp(MyApp(initialToken: token));
}

class MyApp extends StatelessWidget {
  final String? initialToken;

  const MyApp({
    super.key,
    required this.initialToken,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: templateService.primaryColor ?? Colors.deepPurple,
        ),
      ),
      home: initialToken == null ? const LoginScreen() : const ProfileScreen(),
    );
  }
}
