class AuthUser {
  const AuthUser({
    required this.id,
    required this.username,
    required this.nickname,
    required this.role,
  });

  factory AuthUser.fromJson(Map<String, Object?> json) {
    return AuthUser(
      id: _intValue(_pick(json, ['id', 'userId', 'user_id'])),
      username: _stringValue(
        _pick(json, ['username', 'userName', 'user_name']),
      ),
      nickname: _stringValue(
        _pick(json, ['nickname', 'nickName', 'nick_name']),
      ),
      role: _stringValue(_pick(json, ['role', 'userRole', 'user_role'])),
    );
  }

  final int id;
  final String username;
  final String nickname;
  final String role;

  Map<String, Object?> toJson() {
    return {'id': id, 'username': username, 'nickname': nickname, 'role': role};
  }
}

class AuthSessionState {
  const AuthSessionState({required this.token, required this.user});

  final String token;
  final AuthUser user;

  Map<String, Object?> toJson() {
    return {'token': token, 'user': user.toJson()};
  }
}

Object? _pick(Map<String, Object?> json, List<String> keys) {
  for (final key in keys) {
    if (json.containsKey(key)) {
      return json[key];
    }
  }
  return null;
}

int _intValue(Object? value) {
  return switch (value) {
    final int value => value,
    final String value => int.tryParse(value) ?? 0,
    _ => 0,
  };
}

String _stringValue(Object? value) {
  return switch (value) {
    final String value => value,
    final num value => value.toString(),
    _ => '',
  };
}
