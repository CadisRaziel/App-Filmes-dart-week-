import 'package:vhs_filmes/models/movie_detail_model.dart';
import 'package:vhs_filmes/models/movie_model.dart';

abstract class MoviesService {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailModel?> getDeatil(int id);
}