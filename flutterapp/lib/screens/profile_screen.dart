import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/secure_auth_service.dart';
import 'login_screen.dart';
import 'events_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();
  Map<String, dynamic>? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final token = await _auth.getToken();
    if (token == null) return;
    final data = await _api.getProfile(token);
    setState(() => _profile = data);
  }

  Future<void> _logout() async {
    await _auth.clearToken();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: _profile == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hello ${_profile!['name'] ?? ''}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const EventsScreen()),
                      );
                    },
                    child: const Text('View Events'),
                  ),
                ],
              ),
      ),
    );
  }
}
