// ignore_for_file: prefer_const_constructors, unused_field

import 'package:get/get.dart';
import 'package:vhs_filmes/services/login/login_service.dart';
import 'package:vhs_filmes/shared/UI/loader/loader_mixin.dart';
import 'package:vhs_filmes/shared/UI/message/message_mixin.dart';


class LoginController extends GetxController with LoaderMixin, MessageMixin {
  final LoginService _loginService;

  //*estado que ficará sendo alterado toda hora por isso o obs
  final loading = false.obs;

  final message = Rxn<MessageModel>();

  //*Construtor do login
  LoginController({required LoginService loginService})
      : _loginService = loginService;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  Future<void> loginGoogle() async {
    try {
      loading(true);
      await _loginService.loginGoogle();
      loading(false);
      message(
        MessageModel.info(title: 'Sucesso', message: 'Login realizado com sucesso'));
    } catch (e, s) {
      //* s -> vai mostrar toda a tragetória do dart
      print(e);
      print(s);
      loading(false);
      message(
        MessageModel.error(title: 'Erro', message: 'Erro ao realizar o login'));
    }
  }

  Future<void> loginFacebook() async {
    try {
      loading(true);
      await _loginService.loginFacebook();
      loading(false);
      message(
        MessageModel.info(title: 'Sucesso', message: 'Login realizado com sucesso'));
    } catch (e, s) {
      //* s -> vai mostrar toda a tragetória do dart
      print(e);
      print(s);
      loading(false);
      message(
        MessageModel.error(title: 'Erro', message: 'Erro ao realizar o login'));
    }
  }
}

//*O getX não usa setSate, ele usa 'streamers'


//*Classe controlada utilizando Rx
//*RxString -> torna um valor observavel(reativa) [tem que ser utilizando Rx junto com o getx, e não apenas String]
// RxString nome = RxString('Vitor');

//*fazendo dessa forma é a mesma coisa que fazer o RxString !! 
// var nome1 = 'Vitor'.obs;

//*Podemos tipar o Rx que é a mesma coisa que fazer das duas fomras acima (TIPANDO FICA MAIS LEGIVEL !!)
// var nome2 = Rx<String>('Vitor');

//*Sempre que usamos um Rx ele não deixa que o valor seja nullo ou vazio...
//*Para isso precisamos utilizar o 'Rxn'
// var name = Rxn<String>();



//   Future<void> login() async {
//     loading.value = true;
    // loading(true); -> por ser um 'Rx' posso fazer dessa forma, é uma classe que pode ser chamado como 'função', todos Rx pode ser feito isso

   // await Future.delayed(Duration(seconds: 2));
//     //*Repare que ao inves de fazer da forma convencional como acima, podemos fazer utilizando o get como abaixo
//     //*o que deixa mais facil !
//     await 2.seconds.delay();

//     loading.value = false;
    // loading(false); -> por ser um 'Rx' posso fazer dessa forma, é uma classe que pode ser chamado como 'função', todos Rx pode ser feito isso

//     message(MessageModel.error(title: 'Erro', message: 'Mensagem de erro'));
//     await 2.seconds.delay();
//     message(MessageModel.info(title: 'Erro', message: 'Mensagem de erro'));
//   }
