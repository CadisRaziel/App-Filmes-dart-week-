

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/route_manager.dart';

class AuthService  extends GetxService{

  //*Para poder favoritar um filme, precisamos guardar o usuario
  User? user;


  void init(){
    //*A hora que eu inicializar essa classe, eu quero ficar escutando do firebase se o usuario esta logado
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      if(user == null){
        //*Se o usuario nao estiver logado
        Get.offAllNamed('/login');
      } else {
        //*Se o usuario estiver logado
        Get.offAllNamed('home');
      }
     });
  }
}