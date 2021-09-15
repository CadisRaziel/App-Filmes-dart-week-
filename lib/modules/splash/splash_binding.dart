import 'package:get/get.dart';
import 'package:vhs_filmes/modules/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    //*Ou seja, para não precisarmos instanciar diretamente na pagina 'SplashPage' e torna-la um statefull, nos instanciamos tudo aqui
    //*aqui fara o gerenciamento das instancias, separando da pagina 'SplashPage'
    //*e quem fara o gerenciamento é o SplashController
    //*è importante pois o get vai utilizar o guiche(binding) e se nao tiver utilizando ele tira
    //* (resumindo na hora que ele sair da SplashPage ele vai matar esse guiche para não consumir memoria etc.. porque ele nao precisa mais dela, quem precisa é a SplashPage, outra pagina não)
    Get.put(SplashController());
  }
}