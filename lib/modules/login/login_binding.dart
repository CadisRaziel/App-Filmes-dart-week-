import 'package:get/get.dart';
import 'package:vhs_filmes/modules/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    //*Aqui nos vamos colocar nossos service !!
    Get.lazyPut(() => LoginController(loginService: Get.find()));
  }
}
//*lazyPut -> diferente do put que ja instancia diretamente, o lazyput não deixa o loginController na memoria
//*só sera colocado em memoria quando precisar (ele fica disponivel mais só é usado pelo controller quando ele precisar)
