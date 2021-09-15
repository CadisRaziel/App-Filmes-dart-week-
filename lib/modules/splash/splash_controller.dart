// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

//*Como explicado no arquivo 'init_state_dispose.txt' sobre ciclo de vida, o 'GetxController' nos deu um ciclo de vida igual !!

class SplashController extends GetxController {
  //*Quando a tela tiver pronta eu quero ir para alguma pagina, com isso usamos o onReady()

  @override
  void onReady() {
    //*Aqui dentro faremos um 'check' se nosso usuario esta logado ou não
    //!como ainda nao tem nada implementado sobre login, vamos mandar ele pra pagina de login (apagar quando implementar o check completo)
    super.onReady();
    //? não podemos utilizar um navigator pois não temos o contexto aqui no controller
    //? para isso iremos usar o 'Get.offAllNamed'
    Get.offAllNamed('/login');
  }
}