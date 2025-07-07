import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'api_service.dart';
import 'auth_service.dart';
import '../firebase_options.dart';

class PushService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final ApiService _api = ApiService();
  final AuthService _auth = AuthService();

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await _messaging.requestPermission();

    final fcmToken = await _messaging.getToken();
    final authToken = await _auth.getToken();
    if (fcmToken != null && authToken != null) {
      await _api.registerDeviceToken(fcmToken, authToken);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        // For demo purposes simply print the notification
        // In a real app you might show a dialog or snackbar
        // ignore: avoid_print
        print('Push: ${notification.title} - ${notification.body}');
      }
    });
  }
}
