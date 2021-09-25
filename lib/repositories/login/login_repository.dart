import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  //*UserCredential -> credential do firebase
  Future<UserCredential> loginGoogle();
  Future<UserCredential> loginFacebook();

  Future<void> logout();
}