import 'package:flutter/material.dart';

import 'package:vhs_filmes/models/movie_detail_model.dart';

class MovieDetailHeader extends StatelessWidget{
  final MovieDetailModel? movie;

  const MovieDetailHeader({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //*Aqui estou realizando uma promoção de tipo para não ficar colocando '!' ou '?'
    var movieData = movie;
    if (movieData != null) {
      return SizedBox(
        height: 278,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieData.urlImages.length,
            itemBuilder: (context, index) {
              final image = movieData.urlImages[index];
              return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.network(image));
            }),
      );
    } else {
      //*SizedBox.shrink -> é um componente que não tem nada (é pequeno, para quando queremos deixar espaço em branco, uma alternativa ao container em branco)
      return SizedBox.shrink();
    }
  }
}
