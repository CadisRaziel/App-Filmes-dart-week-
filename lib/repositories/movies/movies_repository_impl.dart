import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:vhs_filmes/application/rest_client/rest_client.dart';
import 'package:vhs_filmes/models/movie_detail_model.dart';
import 'package:vhs_filmes/models/movie_model.dart';

import './movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final RestClient _restClient;
  MoviesRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final result = await _restClient.get<List<MovieModel>>(
      '/movie/popular',
      query: {
        //*query -> é um map de APENAS 'string, string'
        //*Aqui estamos indo buscar la no firebase no RemoteCOnfig nossa chave de Api que coolocamos la !!
        'api_key': RemoteConfig.instance.getString('api_token'),
        'language': 'pt-br',
        'page': '1',
      },
      decoder: (data) {
        final results = data['results'];
        if (results != null) {
          return results
              .map<MovieModel>((video) => MovieModel.fromMap(video))
              .toList();
        }

        return <MovieModel>[];
      },
    );
    if (result.hasError) {
      print('Erro ao buscar popular movies [${result.statusText}]');
      throw Exception('Erro ao buscar os filmes populares');
    }

    return result.body ?? <MovieModel>[];
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final result = await _restClient.get<List<MovieModel>>(
      '/movie/top_rated',
      query: {
        //*query -> é um map de APENAS 'string, string'
        //*Aqui estamos indo buscar la no firebase no RemoteCOnfig nossa chave de Api que coolocamos la !!
        'api_key': RemoteConfig.instance.getString('api_token'),
        'language': 'pt-br',
        'page': '1'
      },
      decoder: (data) {
        final results = data['results'];
        if (results != null) {
          return results
              .map<MovieModel>((video) => MovieModel.fromMap(video))
              .toList();
        }

        return <MovieModel>[];
      },
    );
    if (result.hasError) {
      print('Erro ao buscar popular movies [${result.statusText}]');
      throw Exception('Erro ao buscar os filmes populares');
    }

    return result.body ?? <MovieModel>[];
  }

  //*Repare que esse não é um list
  @override
  Future<MovieDetailModel?> getDeatil(int id) async {
    final result =
        await _restClient.get<MovieDetailModel?>('/movie/$id', query: {
      //*query -> é um map de APENAS 'string, string'
      //*Aqui estamos indo buscar la no firebase no RemoteCOnfig nossa chave de Api que coolocamos la !!
      'api_key': RemoteConfig.instance.getString('api_token'),
      'language': 'pt-br',
      'append_to_response': 'images,credits',
      'include_image_language': 'en,pt-br',
    },
            //*Converse o objeto chave valor acima /\ para 'MovieDetailModel'
            decoder: (data) {
      //*Porque não final como fiz nos outros?
      //*Porque o valor que vem de dentro da requisição dessa url ja é o nosso objeto, nao precisamos acessar alguma coisa para chegar nela
      //*podemos acessa-la direto
      return MovieDetailModel.fromMap(data);
    });
    if (result.hasError) {
      print('Erro ao buscar detalhes do filme [${result.statusText}]');
      throw Exception('Erro ao buscar detalhes do filme');
    }
    return result.body;
  }
}
