import 'package:get/get.dart';
import 'package:vhs_filmes/application/auth/auth_service.dart';
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

  final AuthService _authService;

  //*Para quando eu clicar em algum genero ele vai carregar uma nova lista com o genero que eu escolher
  //*Isso vai mudar a lista, e quando eu desmarcar ele vai tirar a seleção e voltar pra lista padrao
  //*fazendo isso não preciso ir no backend
  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];

  //*Variavel para filtro de generos (vai ser nula por isso o rxn)
  final genreSelected = Rxn<GenreModel>();

  MovieController(
      {required GenresService genreService,
      required MoviesService movieService,
      required AuthService authService})
      : _genresService = genreService,
        _moviesService = movieService,
        _authService = authService;

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

      await getMovies();
    } catch (e, s) {
      print(e);
      print(s);
      //*Caso ocorra um erro...
      _message(MessageModel.error(
          title: 'Erro', message: 'Erro ao carregar dados da página'));
    }
  }

  Future<void> getMovies() async {
    try {
      //*fazendo a busca dos movies
      var popularMoviesData = await _moviesService.getPopularMovies();
      var topRatedMoviesData = await _moviesService.getTopRatedMovies();

      final favorites = await getFavorites();

      //*Loop para ver se precisa transformar em true ou não
      popularMoviesData = popularMoviesData.map((movie) {
        if(favorites.containsKey(movie.id)) {
          //*se tiver a key movie.id, eu vou retornar o favorite para true
          return movie.copyWith(favorite: true);
        }else {
          //*se não
          return movie.copyWith(favorite: false);
        }
      }).toList();
      //*Loop para ver se precisa transformar em true ou não
      topRatedMoviesData = topRatedMoviesData.map((movie) {
        if(favorites.containsKey(movie.id)) {
          //*se tiver a key movie.id, eu vou retornar o favorite para true
          return movie.copyWith(favorite: true);
        }else {
          //*se não
          return movie.copyWith(favorite: false);
        }
      }).toList();

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

  Future<void> favoriteMovies(MovieModel movie) async {
    //*inicialmente precisamos pegar o usuario logado
    final user = _authService.user;
    if (user != null) {
      //*Utilizando o copyWith eu consigo pega apenas o valor que eu quero, e como la na 'movie_model' ele vem como true
      //*aqui eu coloco como false adicionando o '!'
      var newMovie = movie.copyWith(favorite: !movie.favorite);
      await _moviesService.addOrRemoveFavorite(user.uid, newMovie);

      //*e ai atualizamos nossa lista
      //*Para o coração mudar de cor
      await getMovies();
    }
  }

  //*Buscar os dados
  //*Aqui eu vo pegar todos os meus movies e pegar o id deles,
  //*porque, teremos varios e varios filmes, e com isso vai verificar se tal filme ja esta no favotiros
  Future<Map<int, MovieModel>> getFavorites() async {
    var user = _authService.user;
    if (user != null) {
      final favorites = await _moviesService.getFavoritiesMovie(user.uid);
      return <int, MovieModel>{
        //*aqui vai me gerar um map de chave e valor
        for (var fav in favorites) fav.id: fav,
      };
    }
    return {};
  }
}
