import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './login_repository.dart';

//*Realizando login com o google (utilizando os acessos do token e o idtoken)

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<UserCredential> loginGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      return FirebaseAuth.instance.signInWithCredential(credential);
    }
    //*Caso seja nulo lança esse erro
    throw Exception('Error ao realizar o login com o google');
  }

  @override
  Future<void> logout() async {
    //*GoogleSignIn -> se eu nao colocar isso, ele desloga mais na hora de logar denovo ele não pede a conta e loga com o utlimo usuario
    //*Obrigatório por
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserCredential> loginFacebook() async {
    // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
