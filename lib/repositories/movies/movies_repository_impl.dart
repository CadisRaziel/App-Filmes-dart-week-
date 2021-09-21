import 'package:cloud_firestore/cloud_firestore.dart';
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

  //*ao inves de criamos uma tabela direto no Firestore, vamos cria-la aqui diretamente
  //*Aqui vamos criar a collection (poderiamos criar no firestore, mais vamos criar aqui diretamente)
  @override
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie) async {
    //? Nossa collection principal chama 'favorities', dentro dela temos o nosso usuario(userId)
    //? dentro dessa collection principal eu vou criar uma nova collection
    //? porque dentro da favorities vai ter varios movies cadastrados
    var favoriteCollection = FirebaseFirestore.instance
        .collection('favorities')
        .doc(userId)
        .collection('movies');

    //? Se eu to adicionando nos favoritos ou removendo dos favoritos
    if (movie.favorite) {
      //*Se tiver true vamos adicionar ao favoritos
      favoriteCollection.add(movie.toMap());
    } else {
      //*Se for false, vamos remover do favoritos
      //? Para isso faremos uma query dentro do firebase e buscar dados dentro da collection 'favorities' e 'movies'
      //*limit -> quero que me traga apenas 1
      try {
        var favoriteData = await favoriteCollection
            .where('id', isEqualTo: movie.id)
            .limit(1)
            .get();

        //*Como eu coloquei o 'limit(1)' eu posso fazer direto aqui, pois como só tem 1 ele só vai pega ele
        //*Se nao eu teria que fazer um 'for'
        favoriteData.docs.first.reference.delete();
      } catch (e) {
        print('Erro ao favoritar um filme');
        rethrow;
      }
    }
  }

  //*identificar se o movie ta como true ou false(se foi favoritado ou não)
  @override
  Future<List<MovieModel>> getFavoritiesMovie(String userId) async {
    var favoritesMovies = await FirebaseFirestore.instance
        .collection('favorities')
        .doc(userId)
        .collection('movies')
        .get(); //? get vai pegar

    //? convertendo essa query acima em um movieModel
    final listFavorites = <MovieModel>[];
    //* .docs para pegar as linhas dessa collection
    for (var movie in favoritesMovies.docs) {
      listFavorites.add(
        MovieModel.fromMap(
          movie.data(),
        ),
      );
    }
    return listFavorites;
  }
}
