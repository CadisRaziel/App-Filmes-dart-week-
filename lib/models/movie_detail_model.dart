import 'dart:convert';

import 'package:vhs_filmes/models/cast_model.dart';
import 'package:vhs_filmes/models/genre_model.dart';

class MovieDetailModel {
  final String tittle;
  final double stars;
  final List<GenreModel> genres;
  final List<String> urlImages;
  final DateTime releaseDate;
  final String overview;
  final List<String> productionsCompanies;
  final String originalLanguage;
  final List<CastModel> cast;

  MovieDetailModel({
    required this.tittle,
    required this.stars,
    required this.genres,
    required this.urlImages,
    required this.releaseDate,
    required this.overview,
    required this.productionsCompanies,
    required this.originalLanguage,
    required this.cast,
  });

  Map<String, dynamic> toMap() {
    return {
      'tittle': tittle,
      'stars': stars,
      'genres': genres.map((x) => x.toMap()).toList(),
      'urlImages': urlImages,
      'releaseDate': releaseDate.millisecondsSinceEpoch,
      'overview': overview,
      'productionsCompanies': productionsCompanies,
      'originalLanguage': originalLanguage,
      'cast': cast.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieDetailModel.fromMap(Map<String, dynamic> map) {
    //? Aqui eu preciso alterar os nomes de dentro dos [''] para ficar exatamente igual da api !!

    //*as images tem um objeto com varias coisas, e precisamos converter para pegar somente o que precisamos
    ///https://api.themoviedb.org/3/movie/436969?api_key=7cb24c6030d761718fa42736d3e947b8&language=pt-br&append_to_response=images,credits&include_image_language=en,pt-br
    //!aqui fizemos a conversão do return la em baixo (é uma opção, agora repare no production_companies vou fazer la em baixo a conversão)
    var urlImagesPosters = map['images']['posters'];
    var urlImages = urlImagesPosters
            ?.map<String>((imagem) =>
                'https://image.tmdb.org/t/p/w200${imagem['file_path']}')
            .toList() ??
        const [];

    return MovieDetailModel(
      //*productCompanies = production_companies(api)
      //*releaseDate = release_date(api)
      //*originalLanguage = original_language(api)
      //*tittle = title(api) 'poderia ser original_title' porém vai vir só os titulos em ingles, o 'title' ja traz em portugues
      tittle: map['title'] ?? '',
      stars: map['vote_average'] ?? 0.0,
      genres: List<GenreModel>.from(
          map['genres']?.map((x) => GenreModel.fromMap(x)) ?? const []),
      urlImages: urlImages,
      releaseDate: DateTime.parse(map['release_date']),
      overview: map['overview'],
      productionsCompanies:
          //*Diferente da urlImage eu fiz a conversao aqui diretamente, os dois jeitos dão o mesmo resultado !
          List<dynamic>.from(map['production_companies'] ?? const [])
              .map<String>((productions) => productions['name'])
              .toList(),
      originalLanguage: map['original_language'],
      cast: List<CastModel>.from(
          //? Repare que quando vou pegar algo que esta dentro de outra coisa, pra min acessar eu vou fazendo assim \/
          //? aqui o 'cast' esta dentro de 'credits' por isso eu primeiro preciso acessar os creditis e ai sim eu acesso o cast
          map['credits']['cast']?.map((x) => CastModel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailModel.fromJson(String source) =>
      MovieDetailModel.fromMap(json.decode(source));
}
