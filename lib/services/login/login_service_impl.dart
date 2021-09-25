// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vhs_filmes/repositories/login/login_repository.dart';

import './login_service.dart';

class LoginServiceImpl implements LoginService {
  LoginRepository _loginRepository;

  //*precisamos criar esse construtor com as variaveis sendo privada 
  //*Pois o service é a regra de negocio 
  LoginServiceImpl({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  @override
  Future<UserCredential> loginGoogle() => _loginRepository.loginGoogle();

  @override
  Future<void> logout() => _loginRepository.logout();

  @override
  Future<UserCredential> loginFacebook() => _loginRepository.loginFacebook();

 
}
