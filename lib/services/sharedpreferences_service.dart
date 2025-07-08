import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() => _instance;

  SharedPreferencesService._internal();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _accessTokenKey = "access_token";
  static const String _tokenTypeKey = "token_type";

  Future<void> saveAuthToken({
    required String accessToken,
    required String tokenType,
  }) async {
    await _prefs?.setString(_accessTokenKey, accessToken);
    await _prefs?.setString(_tokenTypeKey, tokenType);
  }

  String? getAccessToken() => _prefs?.getString(_accessTokenKey);

  String? getTokenType() => _prefs?.getString(_tokenTypeKey);

  String? getAuthHeader() {
    final token = getAccessToken();
    final type = getTokenType();
    if (token != null && type != null) {
      return "$type $token";
    }
    return null;
  }

  Future<void> clearAuthToken() async {
    await _prefs?.remove(_accessTokenKey);
    await _prefs?.remove(_tokenTypeKey);
  }

  bool isLoggedIn() {
    final token = getAccessToken();
    final type = getTokenType();
    if (token != null && type != null) {
      return true;
    }
    return false;
  }
}
