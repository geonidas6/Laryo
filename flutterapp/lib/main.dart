import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'services/secure_auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/events_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: '.env');
  final auth = SecureAuthService();
  final token = await auth.getToken();
  runApp(MyApp(initialToken: token));
}

class MyApp extends StatelessWidget {
  final String? initialToken;
  const MyApp({super.key, this.initialToken});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final navigator = Navigator.of(context);
      final snackBar = SnackBar(
        content: Text(message.notification?.title ?? 'Notification'),
      );
      ScaffoldMessenger.of(navigator.context).showSnackBar(snackBar);
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: initialToken == null ? const LoginScreen() : const ProfileScreen(),
    );
  }
}
