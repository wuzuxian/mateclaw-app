import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/debug/debug_log.dart';
import '../data/auth_models.dart';
import '../data/auth_session_store.dart';

class AuthSession extends ChangeNotifier {
  AuthSession({required AuthSessionStore store}) : _store = store;

  final AuthSessionStore _store;

  AuthSessionState? _state;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  bool get isAuthenticated => _state?.token.isNotEmpty ?? false;

  String? get token => _state?.token;

  AuthUser? get user => _state?.user;

  Future<void> restore() async {
    debugLog('AuthSession.restore start');
    try {
      _state = await _store.read();
      debugLog(
        'AuthSession.restore loaded',
        data: {
          'hasState': _state != null,
          'isAuthenticated': isAuthenticated,
          'userId': _state?.user.id,
          'username': _state?.user.username,
        },
      );
    } catch (_) {
      _state = null;
      debugLog('AuthSession.restore failed');
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> update(AuthSessionState state) async {
    debugLog(
      'AuthSession.update start',
      data: {'userId': state.user.id, 'username': state.user.username},
    );
    await _store.save(state);
    _state = state;
    debugLog(
      'AuthSession.update done',
      data: {'userId': state.user.id, 'isAuthenticated': isAuthenticated},
    );
    notifyListeners();
  }

  Future<void> clear() async {
    debugLog('AuthSession.clear start');
    try {
      await _store.clear();
    } catch (_) {}
    _state = null;
    debugLog('AuthSession.clear done');
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_store.close());
    super.dispose();
  }
}
