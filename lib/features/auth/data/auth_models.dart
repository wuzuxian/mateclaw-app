class AuthUser {
  const AuthUser({
    required this.id,
    required this.username,
    required this.nickname,
    required this.role,
  });

  factory AuthUser.fromJson(Map<String, Object?> json) {
    return AuthUser(
      id: switch (json['id']) {
        final int value => value,
        final String value => int.tryParse(value) ?? 0,
        _ => 0,
      },
      username: json['username'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      role: json['role'] as String? ?? '',
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
