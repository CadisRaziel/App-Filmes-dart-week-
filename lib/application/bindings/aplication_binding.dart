import 'package:get/get.dart';
import 'package:vhs_filmes/application/auth/auth_service.dart';
import 'package:vhs_filmes/repositories/login/login_repository.dart';
import 'package:vhs_filmes/repositories/login/login_repository_impl.dart';
import 'package:vhs_filmes/services/login/login_service.dart';
import 'package:vhs_filmes/services/login/login_service_impl.dart';

class AplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(), fenix: true);
    Get.lazyPut<LoginService>(
        () => LoginServiceImpl(loginRepository: Get.find()),
        fenix: true);

    //*quando carregar a aplicação, vai verificar se ta logado ou não
    Get.put(AuthService()).init();
  }
}

//*Vamos colocar os services aqui pois vai ser usado em toda aplicação !!


//*put -> permanet
//*LazyPut -> fenix
//*fenix -> impede que o binding seja morto pelo getx, ou seja sempre que eu saia de qualquer modulo, ele mantem essa instancia no ar

//*Lembre-se sempre que o binding é utilizado o getx mata ele, nao deixa em memoria
//*com isso o permanet e o fenix nao deixa ele morrer

//? LEMBRE-SE AO FAZER ISSO COLOQUE NO 'APP_WIDGET.DART' ESSE CÒDIGO ' initialBinding: AplicationBinding(),'
//? pois esse initialBindg vai agrupar os binding permanente do sistema, os que nao morrerm