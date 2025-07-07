import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/secure_auth_service.dart';
import 'login_screen.dart';
import '../widgets/badge_wall.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();
  Map<String, dynamic>? _profile;
  List<dynamic>? _badges;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final token = await _auth.getToken();
    if (token == null) return;
    final data = await _api.getProfile(token);
    final badges = await _api.getUserBadges(token);
    setState(() {
      _profile = data;
      _badges = badges;
    });
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
      body: _profile == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello ${_profile!['name'] ?? ''}'),
                const SizedBox(height: 20),
                if (_badges != null)
                  Expanded(child: BadgeWall(badges: List<Map<String, dynamic>>.from(_badges!))),
              ],
            ),
    );
  }
}
