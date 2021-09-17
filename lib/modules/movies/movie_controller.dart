import 'package:get/get.dart';
import 'package:vhs_filmes/models/genre_model.dart';
import 'package:vhs_filmes/models/movie_model.dart';
import 'package:vhs_filmes/services/genres/genres_service.dart';
import 'package:vhs_filmes/services/movies/movies_service.dart';
import 'package:vhs_filmes/shared/UI/message/message_mixin.dart';

class MovieController extends GetxController with MessageMixin {
  final GenresService _genresService;

  final MoviesService _moviesService;

  final _message = Rxn<MessageModel>();

  //*Para ficar observando as mundanças
  final genresGenero = <GenreModel>[].obs;

  //*Buscando a lista de filmes
  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;

  //*Para quando eu clicar em algum genero ele vai carregar uma nova lista com o genero que eu escolher
  //*Isso vai mudar a lista, e quando eu desmarcar ele vai tirar a seleção e voltar pra lista padrao
  //*fazendo isso não preciso ir no backend
  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];

  //*Variavel para filtro de generos (vai ser nula por isso o rxn)
  final genreSelected = Rxn<GenreModel>();

  MovieController({
    required GenresService genreService,
    required MoviesService movieService,
  })  : _genresService = genreService,
        _moviesService = movieService;

  //*Para ficar escutando as alterações (caso tenha erro)
  @override
  void onInit() {
    super.onInit();
    messageListener(_message);
  }

  //*Fazendo a leitura dos nossos dados
  //*Quando a tela tiver pronta vamos fazer a busca dos dados por isso o onReady
  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      final genres = await _genresService.getGenres();
      //*assignAll -> Busca todos os dados e vai sobrescever tudo que estiver na lista
      genresGenero.assignAll(genres);

      //*fazendo a busca dos movies
      final popularMoviesData = await _moviesService.getPopularMovies();
      final topRatedMoviesData = await _moviesService.getTopRatedMovies();
      popularMovies.assignAll(popularMoviesData);
      _popularMoviesOriginal = popularMoviesData;

      topRatedMovies.assignAll(topRatedMoviesData);
      _topRatedMoviesOriginal = topRatedMoviesData;
    } catch (e, s) {
      print(e);
      print(s);
      //*Caso ocorra um erro...
      _message(MessageModel.error(
          title: 'Erro', message: 'Erro ao carregar dados da página'));
    }
  }

  //*criando filtro do campo de pesquisa
  void filterByName(String title) {
    if (title.isNotEmpty) {
      //*Se não for vazio
      //*where -> retorna um bool
      //*toLowerCase -> mesmo se o usuario colocar em maiuscula ele vai transformar tudo em minusculo
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      //*Se for vazio
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  //*Criando filtro pelas tags
  void filterByGenero(GenreModel? genreModel) {
    //*Se eu clicar no genero ele seleciona, porém se eu clicar denovo no mesmo genero ele desmarca ele
   
    if (genreModel?.id == genreSelected.value?.id) {
      //*se ja estiver selecionado
      genreModel = null;
    }
    genreSelected.value = genreModel;

    if (genreModel != null) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.genres.contains(genreModel?.id);
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.genres.contains(genreModel?.id);
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }
}
