import 'package:flutter/foundation.dart';

import '../../../repositories/auth_repository.dart';

class ForgotPasswordController extends ChangeNotifier {
  ForgotPasswordController({
    AuthRepository? authRepository,
  }) : _authRepository =
            authRepository ?? AuthRepository();

  final AuthRepository _authRepository;

  bool _isLoading = false;
  bool _success = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  bool get success => _success;

  String? get errorMessage => _errorMessage;

  Future<bool> sendResetEmail(String email) async {
    _isLoading = true;
    _success = false;
    _errorMessage = null;

    notifyListeners();

    try {
      await _authRepository.sendPasswordResetEmail(
        email: email,
      );

      _success = true;
      return true;
    } catch (e) {
      _errorMessage =
          'Unable to send reset email. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}