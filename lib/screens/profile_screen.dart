import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/theme.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  bool _isLogin = true;
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
      _formKey.currentState?.reset();
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        final user = Provider.of<AuthService>(context, listen: false).currentUser;
        if (user != null) {
          _nameController.text = user.name;
          _emailController.text = user.email;
          _phoneController.text = user.phoneNumber ?? '';
          _addressController.text = user.address ?? '';
        }
      }
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = Provider.of<AuthService>(context, listen: false);
    
    if (_isLogin) {
      // Login
      final success = await authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authService.error ?? 'Login failed')),
        );
      }
    } else {
      // Register
      final success = await authService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        address: _addressController.text.trim(),
      );
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authService.error ?? 'Registration failed')),
        );
      }
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = Provider.of<AuthService>(context, listen: false);
    
    await authService.updateProfile(
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      address: _addressController.text.trim(),
    );
    
    if (mounted) {
      if (authService.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        setState(() {
          _isEditing = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authService.error!)),
        );
      }
    }
  }

  Future<void> _logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.logout();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;
    final isLoading = authService.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: user == null
                ? _buildAuthForm()
                : _buildProfileContent(user),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            _isLogin ? 'Login' : 'Register',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),
          const SizedBox(height: 30),
          if (!_isLogin) ...[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ).animate().fadeIn().slideX(begin: -0.2, end: 0),
            const SizedBox(height: 16),
          ],
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          if (!_isLogin) ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number (Optional)',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
            ).animate().fadeIn().slideX(begin: -0.2, end: 0),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address (Optional)',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              maxLines: 2,
            ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Submit'),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _toggleAuthMode,
            child: Text(
              _isLogin
                  ? 'Don\'t have an account? Register'
                  : 'Already have an account? Login',
            ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildProfileContent(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundColor: AppTheme.lightBlue,
          child: Text(
            user.name.substring(0, 1).toUpperCase(),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.goldenYellow,
            ),
          ),
        ).animate().fadeIn().scale(),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideY(begin: -0.2, end: 0),
        const SizedBox(height: 8),
        Text(
          user.email,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideY(begin: -0.2, end: 0),
        const SizedBox(height: 30),
        if (_isEditing) ...[
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _toggleEditMode,
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ] else ...[
          _buildProfileInfoTile(
            icon: Icons.phone_outlined,
            title: 'Phone',
            subtitle: user.phoneNumber ?? 'Not provided',
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          _buildProfileInfoTile(
            icon: Icons.location_on_outlined,
            title: 'Address',
            subtitle: user.address ?? 'Not provided',
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _toggleEditMode,
            child: const Text('Edit Profile'),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
        ],
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: _logout,
          child: const Text('Logout'),
        ).animate().fadeIn().slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildProfileInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.goldenYellow),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 