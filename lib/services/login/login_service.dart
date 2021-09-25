import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginService {
  Future<UserCredential> loginGoogle();
  Future<UserCredential> loginFacebook();

  Future<void> logout();
}