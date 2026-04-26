import '../database/LocalStorage.dart';

class JwtTokenService {
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';

  static final LocalStorage _storage = LocalStorage();

  static String? _token;
  static String? _refreshToken;

  static void setToken(String token) {
    _token = token;
  }

  static String? getToken() {
    return _token;
  }

  static String? getRefreshToken() {
    return _refreshToken;
  }

  static Future<void> persistSession({
    required String accessToken,
    String? refreshToken,
  }) async {
    _token = accessToken;
    _refreshToken = refreshToken;
    await _storage.setString(_accessTokenKey, accessToken);
    if (refreshToken != null && refreshToken.trim().isNotEmpty) {
      await _storage.setString(_refreshTokenKey, refreshToken);
    } else {
      await _storage.remove(_refreshTokenKey);
    }
  }

  static Future<bool> hydrateSession() async {
    final accessToken = (await _storage.getString(_accessTokenKey)).trim();
    final refreshToken = (await _storage.getString(_refreshTokenKey)).trim();

    _token = accessToken.isEmpty ? null : accessToken;
    _refreshToken = refreshToken.isEmpty ? null : refreshToken;

    return _token != null && _token!.isNotEmpty;
  }

  static Future<void> clearSession() async {
    _token = null;
    _refreshToken = null;
    await _storage.remove(_accessTokenKey);
    await _storage.remove(_refreshTokenKey);
  }

  static void clearToken() {
    _token = null;
  }
}
