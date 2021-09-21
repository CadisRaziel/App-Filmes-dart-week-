

import 'package:vhs_filmes/models/genre_model.dart';

abstract class GenresService {
  Future<List<GenreModel>> getGenres();

}
