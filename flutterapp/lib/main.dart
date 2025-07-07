import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

import 'services/auth_service.dart';
import 'services/api_service.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final info = await PackageInfo.fromPlatform();
  final platform = Platform.isIOS ? 'ios' : 'android';
  final versionInfo =
      await ApiService().checkVersion(platform, info.version) ?? {};
  final auth = AuthService();
  final token = await auth.getToken();
  runApp(MyApp(initialToken: token, versionInfo: versionInfo));
}

class MyApp extends StatefulWidget {
  final String? initialToken;
  final Map<String, dynamic> versionInfo;
  const MyApp({super.key, this.initialToken, required this.versionInfo});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final info = widget.versionInfo;
    if (info['update_required'] == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: !(info['force_update'] == true),
          builder: (_) => AlertDialog(
            title: const Text('Update Available'),
            content: Text(info['changelog'] ?? ''),
            actions: [
              if (!(info['force_update'] == true))
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Later')),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Update')),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:
          widget.initialToken == null ? const LoginScreen() : const ProfileScreen(),
    );
  }
}
