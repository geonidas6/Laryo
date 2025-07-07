import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/secure_auth_service.dart';
import '../services/settings_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final void Function(bool)? onThemeChanged;
  const ProfileScreen({super.key, this.onThemeChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();
  final SettingsService _settingsService = SettingsService();
  Map<String, dynamic>? _profile;
  Map<String, dynamic> _settings = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadSettings();
  }

  Future<void> _loadProfile() async {
    final token = await _auth.getToken();
    if (token == null) return;
    final data = await _api.getProfile(token);
    setState(() => _profile = data);
  }

  Future<void> _loadSettings() async {
    final data = await _settingsService.loadSettings();
    setState(() => _settings = data);
  }

  Future<void> _updateDarkMode(bool value) async {
    await _settingsService.updateSetting('darkMode', value);
    widget.onThemeChanged?.call(value);
    setState(() {
      _settings['darkMode'] = value;
    });
  }

  Future<void> _updateNotifications(bool value) async {
    await _settingsService.updateSetting('notifications', value);
    setState(() {
      _settings['notifications'] = value;
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
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello ${_profile!['name'] ?? ''}'),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    value: _settings['darkMode'] == true || _settings['darkMode'] == 'true',
                    onChanged: _updateDarkMode,
                  ),
                  SwitchListTile(
                    title: const Text('Notifications'),
                    value: _settings['notifications'] == true || _settings['notifications'] == 'true',
                    onChanged: _updateNotifications,
                  ),
                ],
              ),
            ),
    );
  }
}
