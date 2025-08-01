import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/feature_manager_service.dart';
import '../services/template_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _api = ApiService();
  final AuthService _auth = AuthService();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (templateService.logoUrl != null)
              Image.network(templateService.logoUrl!, height: 80),
            Text(templateService.welcomeText),
            const SizedBox(height: 16),
            _profile == null
                ? const CircularProgressIndicator()
                : Text('Hello ${_profile!['name'] ?? ''}'),
            if (featureManager.isEnabled('new_profile_banner'))
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'New Feature Enabled!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
