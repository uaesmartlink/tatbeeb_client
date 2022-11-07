import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInApi {
  static final _facebookSignIn = FacebookAuth.instance;
   /* scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      "https://www.googleapis.com/auth/userinfo.profile",
    ],
  );*/
  static Future<LoginResult?> login() => _facebookSignIn.login(permissions: [
    'email', 'public_profile', 'user_birthday'
  ]);
  static Future logout() => _facebookSignIn.logOut();
}