import 'dart:async';

import 'package:flutter/foundation.dart';

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
    try {
      _state = await _store.read();
    } catch (_) {
      _state = null;
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> update(AuthSessionState state) async {
    await _store.save(state);
    _state = state;
    notifyListeners();
  }

  Future<void> clear() async {
    if (_state == null) {
      return;
    }

    await _store.clear();
    _state = null;
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_store.close());
    super.dispose();
  }
}
