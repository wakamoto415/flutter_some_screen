import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/shared_preferences_provider.dart';

const _isLoggedInKey = 'auth.isLoggedIn';

class AuthState {
  const AuthState({required this.isLoggedIn});

  final bool isLoggedIn;
}

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return AuthState(isLoggedIn: prefs.getBool(_isLoggedInKey) ?? false);
  }

  Future<void> login() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_isLoggedInKey, true);
    state = const AuthState(isLoggedIn: true);
  }

  Future<void> logout() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_isLoggedInKey, false);
    state = const AuthState(isLoggedIn: false);
  }
}

final authProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
