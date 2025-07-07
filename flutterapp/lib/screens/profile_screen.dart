import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
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
  final _avatarController = TextEditingController();
  final _bioController = TextEditingController();
  final _languageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final token = await _auth.getToken();
    if (token == null) return;
    final data = await _api.getProfile(token);
    setState(() {
      _profile = data;
      _avatarController.text = data?['avatar_url'] ?? '';
      _bioController.text = data?['bio'] ?? '';
      _languageController.text = data?['language'] ?? '';
    });
  }

  Future<void> _save() async {
    final token = await _auth.getToken();
    if (token == null) return;
    await _api.updateProfile(token,
        avatarUrl: _avatarController.text,
        bio: _bioController.text,
        language: _languageController.text);
    await _loadProfile();
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
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _avatarController,
                    decoration: const InputDecoration(labelText: 'Avatar URL'),
                  ),
                  TextField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                  ),
                  TextField(
                    controller: _languageController,
                    decoration:
                        const InputDecoration(labelText: 'Language'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
    );
  }
}
