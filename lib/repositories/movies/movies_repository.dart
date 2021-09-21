import 'package:vhs_filmes/models/movie_detail_model.dart';
import 'package:vhs_filmes/models/movie_model.dart';

abstract class MoviesRepository {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailModel?> getDeatil(int id);

  //*ao inves de criamos uma tabela direto no Firestore, vamos cria-la aqui diretamente
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie);

  //*identificar se o movie ta como true ou false(se foi favoritado ou não)
  //*aqui vamos buscar as informações dentro do nosso firebase
  Future<List<MovieModel>> getFavoritiesMovie(String userId);
  
}