import 'package:get/get.dart';
import 'package:vhs_filmes/application/UI/message/message_mixin.dart';
import 'package:vhs_filmes/models/genre_model.dart';
import 'package:vhs_filmes/services/genres/genres_service.dart';

class MovieController extends GetxController with MessageMixin{
  final GenresService _genresService;

  final _message = Rxn<MessageModel>();

  //*Para ficar observando as mundanças
  final genresGenero = <GenreModel>[].obs;

  MovieController({
    required GenresService genreService,
  }) : _genresService = genreService;




  
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
    }  catch (e) {
      //*Caso ocorra um erro...
      _message(
        MessageModel.error(title: 'Erro', message: 'Erro ao buscar os generos')
      );
    }
  }
}
