import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/secure_auth_service.dart';
import '../services/guide_service.dart';
import '../widgets/guided_tour.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();
  final GuideService _guideService = GuideService();
  Map<String, dynamic>? _profile;
  List<GuideStepModel> _steps = [];
  bool _showTour = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _fetchGuides();
  }

  Future<void> _fetchGuides() async {
    final steps = await _guideService.fetchSteps();
    setState(() => _steps = steps);
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

  void _startTour() {
    if (_steps.isNotEmpty) {
      setState(() => _showTour = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
            ],
          ),
          body: Center(
            child: _profile == null
                ? const CircularProgressIndicator()
                : Text('Hello ${_profile!['name'] ?? ''}'),
          ),
          floatingActionButton: _steps.isEmpty
              ? null
              : FloatingActionButton(
                  onPressed: _startTour,
                  child: const Icon(Icons.help_outline),
                ),
        ),
        if (_showTour)
          GuidedTour(
            steps: _steps,
            onFinished: () => setState(() => _showTour = false),
          ),
      ],
    );
  }
}
