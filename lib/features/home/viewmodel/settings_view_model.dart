import 'package:flutter/foundation.dart';

import '../../../core/debug/debug_log.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/viewmodel/auth_session.dart';
import '../data/home_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel({
    required AuthRepository authRepository,
    required HomeRepository homeRepository,
    required AuthSession authSession,
  }) : _authRepository = authRepository,
       _homeRepository = homeRepository,
       _authSession = authSession;

  final AuthRepository _authRepository;
  final HomeRepository _homeRepository;
  final AuthSession _authSession;

  bool _isLoggingOut = false;

  bool get isLoggingOut => _isLoggingOut;

  Future<void> logout() async {
    if (_isLoggingOut) {
      debugLog('SettingsViewModel.logout skipped');
      return;
    }

    _isLoggingOut = true;
    notifyListeners();
    debugLog('SettingsViewModel.logout start');

    try {
      try {
        await _authRepository.logout();
      } catch (_) {}

      try {
        await _homeRepository.clearCachedHome();
      } catch (_) {}

      await _authSession.clear();
      debugLog('SettingsViewModel.logout done');
    } catch (_) {}
  }
}
