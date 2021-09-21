import 'package:get/get.dart';
import 'package:vhs_filmes/application/auth/auth_service.dart';
import 'package:vhs_filmes/models/movie_model.dart';
import 'package:vhs_filmes/services/movies/movies_service.dart';

class FavoritesController extends GetxController {
  final MoviesService _moviesService;
  final AuthService _authService;

  var movies = <MovieModel>[].obs;

  FavoritesController(
      {required MoviesService movieService, required AuthService authService})
      : _moviesService = movieService,
        _authService = authService;

  @override
  void onReady() {
    super.onReady();
    //*quando tiver pronto vamos buscar nosso movies
    _getFavorites();
  }

  Future<void> _getFavorites() async {
    var user = _authService.user;
    if (user != null) {
      var favorites = await _moviesService.getFavoritiesMovie(user.uid);
      movies.assignAll(favorites);
    }
  }

  //*Metodo para remover da pagina de favoritos
  Future<void> removeFavorite(MovieModel movie) async {
    var user = _authService.user;
    if (user != null) {
      await _moviesService.addOrRemoveFavorite(
          user.uid, movie.copyWith(favorite: false));
      movies.remove(movie);
    }
  }
}
