import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:vhs_filmes/application/rest_client/rest_client.dart';
import 'package:vhs_filmes/models/genre_model.dart';

import './genres_repository.dart';

class GenresRepositoryImpl implements GenresRepository {
  final RestClient _restClient;

  //*fazemos o construtor privado assim pois se eu deixar ele como publico todo mundo vai ter acesso ao restClient, ele nao pode sair do repository
  GenresRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<GenreModel>> getGenres() async {
    //*Repare que eu nao precisie do começo da url 'https://api.themoviedb.org/3'
    //*Pois ja adicionei ela como uma base por isso o 'baseUrl', esta em 'rest_client.dart'
    final result = await _restClient.get<List<GenreModel>>(
      '/genre/movie/list',
      query: {
        //*Aqui estamos indo buscar la no firebase no RemoteCOnfig nossa chave de Api que coolocamos la !!
        'api_key': RemoteConfig.instance.getString('api_token'),
        'language': 'pt-br'
      },
      //*decoder -> responsavel por pega a string e transforma em um model (ou seja vai transformar no nosso GenreModel)
      decoder: (data) {
        final resultData = data['genres'];
        //*agora verificamos se ela não é nula
        if (resultData != null) {
          //*O map vai transformar a lista de chave valor em nosso Model
          return resultData
              .map<GenreModel>((genero) => GenreModel.fromMap(genero))
              .toList();
        }

        //*Caso seje nulo
        return <GenreModel>[];
      },
    );
    //*Caso tenha um erro na requisição
    if(result.hasError) {
      //*Esse print é para mostrar o erro detalhado
      print('Erro ao buscar os generos [${result.statusText}]');
      throw Exception('Erro ao buscar os generos');
    }

    //*Se não deu erro
    return result.body ?? <GenreModel>[];
  }
}
