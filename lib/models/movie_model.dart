import 'dart:convert';

//*Para pegar a imagem da api é necessario por uma url antes
//*w200 -> imagem menor
//*w500 -> imagem maior
//*https://image.tmdb.org/t/p/w200/
//?concatene essa url com o PosterPath la em baixo \/



class MovieModel {
  //*Vamos precisar do id, do titulo, do ano, da foto, da lista de generos, e se foi favoritado ou não
  final int id;
  final String title;
  final String releaseData;
  final String posterPath;
  final List<int> genres;
  final bool favorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.releaseData,
    required this.posterPath,
    required this.genres,
    required this.favorite,
  });

  //*altere os nomes aqui tambem !
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseData,
      'poster_path': posterPath,
      'genre_ids': genres,
      'favorite': favorite,
    };
  }

  //? Lembre-se, os nomes aqui estão diferente da API, por isso precisamos fazer algumas traduções
  //*releaseData = release_date(api)
  //*PosterPath = poster_path(api)
  //*genres = genre_ids(api)
  //! Lembre-se de por ?? 0 - ?? '' - ?? const [] etc...
  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      releaseData: map['release_date'] ?? '',
      //*Antes eu precisie concatenar essa url com o poster_path, porém ao adicionar o cloud firestore iria dar um erro
      //*Pois a imagem seria chamada 2x para isso tivemos que colocar o 'map['poster_paht'] normal
      //*e la no movie_card eu concateno a url (va para movie_card para ver)
      //*aqui estamos concatenando a url como diz na documentação !!
      // posterPath: 'https://image.tmdb.org/t/p/w200/${map['poster_path']}',
      posterPath: map['poster_path'],
      genres: List<int>.from(map['genre_ids'] ?? const []),
      favorite: map['favorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source));


  //*Em movie_controller eu nao posso colocar 'movie.favorite = true;' pois la é imutavel
  //*Precisei adicionar o copyWith aqui 
  //*copyWith -> pega todos os nossos dados que estão em instancia e altera somente aquele que eu quero que seja alterado
  MovieModel copyWith({
    int? id,
    String? title,
    String? releaseData,
    String? posterPath,
    List<int>? genres,
    bool? favorite,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      releaseData: releaseData ?? this.releaseData,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      favorite: favorite ?? this.favorite,
    );
  }
}
