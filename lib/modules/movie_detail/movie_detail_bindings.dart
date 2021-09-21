import 'package:get/get.dart';
import './movie_detail_controller.dart';

class MovieDetailBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(MovieDetailController(
          //*O movieService ja esta declarado la dentro do 'Aplication_binding' por isso colocamos o Get.find() direto aqui
          moviesService: Get.find()
        ));
    }
}