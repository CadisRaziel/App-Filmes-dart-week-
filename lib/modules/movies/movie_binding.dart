import 'package:get/get.dart';
import 'package:vhs_filmes/modules/movies/movie_controller.dart';
import 'package:vhs_filmes/repositories/genres/genres_repository.dart';
import 'package:vhs_filmes/repositories/genres/genres_repository_impl.dart';
import 'package:vhs_filmes/services/genres/genres_service.dart';
import 'package:vhs_filmes/services/genres/genres_service_impl.dart';

class MovieBinding implements Bindings {
  @override
  void dependencies() {
    //*o restClient vai ser buscado pelo Get.find la na pasta 'bindings' em 'aplication'
    Get.lazyPut<GenresRepository>(
      () => GenresRepositoryImpl(
        restClient: Get.find(),
      ),
    );

    //*O get.find vai pegar o repository aqui na linha de cima /\
    Get.lazyPut<GenresService>(
      () => GenresServiceImpl(
        genresRepository: Get.find(),
      ),
    );

    //*O get.find vai pegar o service aqui na linha de cima /\
    Get.lazyPut(
      () => MovieController(
        genreService: Get.find(),        
        movieService: Get.find()
      ),
    );
  }
}
