import 'dart:convert';


class GenreModel {
  //*Model para pegar os dados da lista de genres(generos)
  final int id;
  final String name;
  
  GenreModel({
    required this.id,
    required this.name,
  });


  //*Fazendo a conversão de um json para um model !!
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  //*Fazendo a conversão de um json para um model !!
  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id'],
      name: map['name'],
    );
  }

  //*Fazendo a conversão de um json para um model !!
  String toJson() => json.encode(toMap());

  //*Fazendo a conversão de um json para um model !!
  factory GenreModel.fromJson(String source) => GenreModel.fromMap(json.decode(source));
}
