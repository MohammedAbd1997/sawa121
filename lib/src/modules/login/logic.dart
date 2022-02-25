import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';
import 'package:sawa/src/entities/user_response.dart';
import 'package:sawa/src/modules/on_boarding/view.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

class LoginLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.find();
  bool isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);
  FirebaseAuth _auth = FirebaseAuth.instance;

  void googleSignIn() async {
    isLoading = true;
    update();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//      print(googleUser);

    if (googleUser == null) {
      isLoading = false;
      update();
      return;
    }
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken
        , accessToken: googleSignInAuthentication.accessToken
    );

   await _auth.signInWithCredential(credential);


    if (googleSignInAuthentication == null) {
      isLoading = false;
      update();
      return;
    }
    var idToken = googleSignInAuthentication.idToken;
   //   print(idToken);
    await socialLogin(idToken, "google");


    isLoading = false;
    update();
    //   print(accessToken);
  }

  void loginByFacebook() async {
    isLoading = true;
    update();
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      AccessToken? _accessToken = result.accessToken;
      log(_accessToken!.token);
      await socialLogin(_accessToken.token, "facebook");
    } else {
      print(result.status);
      print(result.message);
    }
    isLoading = false;
    update();
  }

  socialLogin(String? token, String provider) async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.socialLogin(provider, token);
      UserResponse _userResponse = UserResponse.fromJson(response.data);
      log(_userResponse.accessToken.toString());
      _prefManger.setIsLogin(true);
      _prefManger.setToken(_userResponse.accessToken!);
      _prefManger.setFullName(_userResponse.user!.fullName!);
      Get.offNamed('/on-boarding');
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
