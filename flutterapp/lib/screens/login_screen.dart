import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/secure_auth_service.dart';
import 'profile_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  final void Function(bool)? onThemeChanged;
  const LoginScreen({super.key, this.onThemeChanged});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final token = await _api.login(
      _emailController.text,
      _passwordController.text,
    );
    setState(() => _isLoading = false);
    if (token != null) {
      await _auth.saveToken(token);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => ProfileScreen(onThemeChanged: widget.onThemeChanged)),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const RegistrationScreen()),
                  );
                },
                child: const Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
