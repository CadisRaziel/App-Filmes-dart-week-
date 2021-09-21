import 'package:flutter/material.dart';
import 'package:vhs_filmes/models/movie_detail_model.dart';
import 'package:vhs_filmes/modules/movie_detail/widget/movie_detail_content/movie_detail_content_cast.dart';
import 'package:vhs_filmes/modules/movie_detail/widget/movie_detail_content/movie_detail_content_credit.dart';
import 'package:vhs_filmes/modules/movie_detail/widget/movie_detail_content/movie_detail_content_title.dart';
import 'package:vhs_filmes/modules/movie_detail/widget/movie_detail_content/movie_detail_content_production_credits.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContent({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieDetailContentTitle(movie: movie),
        MovieDetailContentCredit(movie: movie),
        MovieDetailContentProductionCredits(movie: movie,),
        MovieDetailContentCast(movie: movie)
      ],
    );
  }
}
