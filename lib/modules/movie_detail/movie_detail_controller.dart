import 'package:get/get.dart';
import 'package:vhs_filmes/models/movie_detail_model.dart';
import 'package:vhs_filmes/services/movies/movies_service.dart';
import 'package:vhs_filmes/shared/UI/loader/loader_mixin.dart';
import 'package:vhs_filmes/shared/UI/message/message_mixin.dart';

class MovieDetailController extends GetxController
    with LoaderMixin, MessageMixin {
  final MoviesService _moviesService;

  //*Controler busca os dados, lembre-se
  var loading = false.obs;
  var message = Rxn<MessageModel>();
  var movie = Rxn<MovieDetailModel>();

  MovieDetailController({required MoviesService moviesService})
      : _moviesService = moviesService;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    //*a hora que a pagina tiver pronta, vai realizar a busca da api(dados)
    //*Repare que eu vou recupera o 'arguments' passado la no 'movie_card.dart' (repare que com o get é muito facil realizar)
    try {
      final movieId = Get.arguments;
      loading(true);
      final movieDetailData = await _moviesService.getDeatil(movieId);
      //?obs: se eu coloquei como 'var movie = Rxn<MovieDetailModel>();'
      //? coloque movie.'value' pois o getx tem um pequeno erro, e o .value concerta
      movie.value = movieDetailData;
      loading(false);
    } catch (e, s) {
      print(e);
      print(s);
      loading(false);
      message(MessageModel.error(
          title: 'Erro', message: 'Erro ao buscar detalhes do filme'));
    }
  }
}
