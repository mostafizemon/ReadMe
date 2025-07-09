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
  static const String _userNamerKey = "user_name";
  static const String _userEmailKey = "user_email";

  Future<void> saveAuthToken({
    required String accessToken,
    required String tokenType,
    String? userName,
    String? userEmail,
  }) async {
    await _prefs?.setString(_accessTokenKey, accessToken);
    await _prefs?.setString(_tokenTypeKey, tokenType);
    await _prefs?.setString(_userNamerKey, userName ?? "");
    await _prefs?.setString(_userEmailKey, userEmail ?? "");
  }

  String? getAccessToken() => _prefs?.getString(_accessTokenKey);

  String? getTokenType() => _prefs?.getString(_tokenTypeKey);

  String? getUserName() => _prefs?.getString(_userNamerKey);

  String? getUserEmail() => _prefs?.getString(_userEmailKey);

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
    await _prefs?.remove(_userNamerKey);
    await _prefs?.remove(_userEmailKey);
  }

  Future<void> updateUserDetails({
    required String userName,
    required String userEmail,
  }) async {
    await _prefs?.setString(_userNamerKey, userName);
    await _prefs?.setString(_userEmailKey, userEmail);
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
