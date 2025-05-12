import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  String? get error => _error;

  AuthService() {
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      _currentUser = User.fromJson(json.decode(userJson));
      notifyListeners();
    }
  }

  Future<void> _saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toJson()));
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
    String? address,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // In a real app, you would make an API call to register the user
      // For this example, we'll simulate a successful registration
      await Future.delayed(const Duration(seconds: 1));
      
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
      );
      
      _currentUser = user;
      await _saveUserToPrefs(user);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // In a real app, you would make an API call to authenticate the user
      // For this example, we'll simulate a successful login
      await Future.delayed(const Duration(seconds: 1));
      
      // Simulate finding a user with the provided email
      final user = User(
        id: '1',
        name: 'Test User',
        email: email,
        phoneNumber: '1234567890',
        address: '123 Test St, Test City',
      );
      
      _currentUser = user;
      await _saveUserToPrefs(user);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      _currentUser = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? address,
  }) async {
    if (_currentUser == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // In a real app, you would make an API call to update the user profile
      // For this example, we'll simulate a successful update
      await Future.delayed(const Duration(seconds: 1));
      
      final updatedUser = User(
        id: _currentUser!.id,
        name: name ?? _currentUser!.name,
        email: _currentUser!.email,
        phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
        address: address ?? _currentUser!.address,
      );
      
      _currentUser = updatedUser;
      await _saveUserToPrefs(updatedUser);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
} 