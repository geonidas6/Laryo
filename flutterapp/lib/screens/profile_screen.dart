import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/secure_auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();
  Map<String, dynamic>? _profile;
  Map<String, dynamic> _experiments = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final token = await _auth.getToken();
    if (token == null) return;
    final data = await _api.getProfile(token);
    final exps = await _api.getExperiments(token);
    setState(() {
      _profile = data;
      _experiments = exps;
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
        body: Center(
          child: _profile == null
              ? const CircularProgressIndicator()
              : _buildContent(),
        ),
      );
  }

  Widget _buildContent() {
    String greeting = 'Hello ${_profile!["name"] ?? ''}';
    if (_experiments['welcome_message'] == 'new') {
      greeting = 'Welcome to the new profile, ${_profile!["name"]}';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(greeting),
        if (_experiments.isNotEmpty) Text('Experiment: ${_experiments}'),
      ],
    );
  }
}
