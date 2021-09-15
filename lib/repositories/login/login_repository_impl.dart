import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './login_repository.dart';

//*Realizando login com o google (utilizando os acessos do token e o idtoken)

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<UserCredential> login() async {
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
}
