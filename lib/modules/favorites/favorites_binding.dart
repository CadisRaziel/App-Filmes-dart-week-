import 'package:get/get.dart';
import 'package:vhs_filmes/modules/favorites/favorites_controller.dart';

class FavoritesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FavoritesController(
      //*os dois abaixo estão no aplication_binding
      authService: Get.find(),
      movieService: Get.find(),
    ));
  }
}
