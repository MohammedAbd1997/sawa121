
import 'shared_preferences.dart';

class PrefManger {
  static const String TOKEN = "TOKEN";
  static const String IS_LOGIN = "IS_LOGIN";
  static const String IS_VENDOR = "IS_VENDOR";
  static const String IS_ARABIC = "IS_ARABIC";
  static const String IS_FIRST_TIME = "IS_FIRST_TIME";
  static const String FULL_NAME = "FULL_NAME";

  //token
  Future setToken(String token) async {
    await savePrefString(TOKEN, token);
  }

  Future<String> getToken() async {
    return await getPrefString(TOKEN);
  }
  //fullName
  Future setFullName(String fullName) async {
    await savePrefString(FULL_NAME, fullName);
  }

  Future<String> getFullName() async {
    return await getPrefString(FULL_NAME);
  }

  //isLogin
  Future setIsLogin(bool isLogin) async {
    await savePrefBool(IS_LOGIN, isLogin);
  }

  Future<bool> getIsLogin() async {
    return await getPrefBool(IS_LOGIN);
  }

  //isVendor
  Future setIsVendor(bool isVendor) async {
    await savePrefBool(IS_VENDOR, isVendor);
  }

  Future<bool> getIsVendor() async {
    return await getPrefBool(IS_VENDOR);
  }
  //isArabicLanguage
  Future setIsArabic(bool isArabic) async {
    await savePrefBool(IS_ARABIC, isArabic);
  }

  Future<bool> getIsArabic() async {
    return await getPrefBool(IS_ARABIC);
  }
  //isFirstTime
  Future setIsFirstTime(bool isFirstTime) async {
    await savePrefBool(IS_FIRST_TIME, isFirstTime);
  }

  Future<bool> getIsFirstTime() async {
    return await getPrefBool(IS_FIRST_TIME);
  }

}
