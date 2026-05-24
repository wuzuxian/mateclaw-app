import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ApiClient {
  ApiClient({
    String? baseUrl,
    String? Function()? authorizationTokenProvider,
    HttpClient? httpClient,
  }) : _baseUri = Uri.parse(
         baseUrl ??
             const String.fromEnvironment(
               'API_BASE_URL',
               defaultValue: 'http://192.168.0.104:18088',
             ),
       ),
       _authorizationTokenProvider = authorizationTokenProvider,
       _httpClient = httpClient ?? HttpClient();

  final Uri _baseUri;
  final String? Function()? _authorizationTokenProvider;
  final HttpClient _httpClient;

  Future<ApiResponse> postJson(
    String path, {
    required Map<String, Object?> body,
    bool requiresAuthorization = true,
  }) async {
    try {
      final request = await _httpClient
          .postUrl(_resolve(path))
          .timeout(const Duration(seconds: 10));

      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, ContentType.json.value);

      if (requiresAuthorization) {
        final token = _authorizationTokenProvider?.call();
        if (token != null && token.isNotEmpty) {
          request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
        }
      }

      request.write(jsonEncode(body));

      final response = await request.close().timeout(
        const Duration(seconds: 20),
      );
      final responseBody = await utf8.decoder.bind(response).join();
      final decodedBody = _decodeBody(responseBody);

      if (decodedBody is! Map<String, Object?>) {
        throw ApiException(
          type: ApiExceptionType.invalidResponse,
          statusCode: response.statusCode,
        );
      }

      final apiResponse = ApiResponse.fromJson(decodedBody);
      if (response.statusCode >= HttpStatus.badRequest ||
          apiResponse.code != HttpStatus.ok) {
        throw ApiException(
          type: ApiExceptionType.server,
          statusCode: response.statusCode,
          apiCode: apiResponse.code,
          message: apiResponse.message,
        );
      }

      return apiResponse;
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(type: ApiExceptionType.network);
    } on SocketException {
      throw const ApiException(type: ApiExceptionType.network);
    } on HttpException {
      throw ApiException(type: ApiExceptionType.network);
    } on HandshakeException {
      throw const ApiException(type: ApiExceptionType.network);
    }
  }

  Uri _resolve(String path) {
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    final basePath = _baseUri.path.endsWith('/')
        ? _baseUri.path
        : '${_baseUri.path}/';
    return _baseUri.replace(path: '$basePath$normalizedPath');
  }

  Object? _decodeBody(String responseBody) {
    if (responseBody.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(responseBody);
    } on FormatException {
      return null;
    }
  }

  void close() {
    _httpClient.close(force: true);
  }
}

class ApiResponse {
  const ApiResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, Object?> json) {
    return ApiResponse(
      code: switch (json['code']) {
        final int value => value,
        final String value => int.tryParse(value) ?? 0,
        _ => 0,
      },
      message: json['msg'] as String? ?? '',
      data: json['data'],
    );
  }

  final int code;
  final String message;
  final Object? data;
}

enum ApiExceptionType { invalidResponse, server, network }

class ApiException implements Exception {
  const ApiException({
    required this.type,
    this.statusCode,
    this.apiCode,
    this.message,
  });

  final ApiExceptionType type;
  final int? statusCode;
  final int? apiCode;
  final String? message;
}
