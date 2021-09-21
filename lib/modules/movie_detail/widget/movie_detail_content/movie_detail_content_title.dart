import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:vhs_filmes/models/movie_detail_model.dart';
import 'package:vhs_filmes/shared/themes/app_color_extension.dart';

class MovieDetailContentTitle extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContentTitle({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            movie?.tittle ?? '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          //*RatingStars -> flutter_rating_stars
          RatingStars(
            value: (movie?.stars ?? 1) / 2,
            //*valueLabelVisibility -> tira o '4.0/5.0' e deixa apenas as estrelas
            valueLabelVisibility: false,
            starColor: context.themeOrange,
            starSize: 14,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            //*join -> metodo join vai colocar uma ',' entre os generos que o filme tirar (exemplo: ação, aventura, drama)
            //*sem o join ficaria ação aventura drama
            //*nao esqueça de por um espaço após a virgula
            movie?.genres.map((e) => e.name).join(', ') ?? '',
            style: TextStyle(fontSize: 11, color: context.themeGrey,),
          )
        ],
      ),
    );
  }
}
