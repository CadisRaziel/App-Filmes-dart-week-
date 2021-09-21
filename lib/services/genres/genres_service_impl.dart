import 'package:vhs_filmes/models/genre_model.dart';
import 'package:vhs_filmes/repositories/genres/genres_repository.dart';

import './genres_service.dart';

class GenresServiceImpl implements GenresService {
  final GenresRepository _genreRepository;

  
  GenresServiceImpl({required GenresRepository genresRepository})
      : _genreRepository = genresRepository;

  @override
  Future<List<GenreModel>> getGenres() => _genreRepository.getGenres();
}
