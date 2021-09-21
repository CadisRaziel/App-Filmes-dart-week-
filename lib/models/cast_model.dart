import 'dart:convert';


class CastModel {
  //*essa classe é sobre informaçoes sobre o elenco (por isso colocamos no 'movie_detail_model.dart')
  final String name;
  final String image;
  final String character;

  
  CastModel({
    required this.name,
    required this.image,
    required this.character,
  });

  Map<String, dynamic> toMap() {
    return {
      //? Aqui não precisa estar exatamente os mesmos nomes da api ok
      'name': name,
      'image': image,
      'character': character,
    };
  }

  factory CastModel.fromMap(Map<String, dynamic> map) {
    //*Fazendo as alterações e pegando os nomes da api
    //? precisamos deixar essa parte exatamente como a api !!!
    //*name = original_name(api),
    //*image = profile_path(api),
    //*character = character(api)
    return CastModel(
      name: map['original_name'] ?? '',
      //*Lembre-se de ver se no 'image' la no postman a url que colcoamos aqui tem uma '/' antes (la tem /euDPYq...., ou seja aqui nao precisamos por w200/)
      image:'https://image.tmdb.org/t/p/w200${map['profile_path'] ?? ''}',
      character: map['character'] ?? '',
    );    
  }

  String toJson() => json.encode(toMap());

  factory CastModel.fromJson(String source) => CastModel.fromMap(json.decode(source));
}
