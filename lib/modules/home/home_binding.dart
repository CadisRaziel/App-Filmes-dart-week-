import 'package:get/get.dart';
import 'package:vhs_filmes/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //*Fenix true pois se não da erro ao voltar para o icone 'filmes'
    Get.lazyPut(() => HomeController(loginService: Get.find()), fenix: true);
  }
}