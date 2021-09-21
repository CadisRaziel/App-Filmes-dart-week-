// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:vhs_filmes/models/movie_detail_model.dart';

class MovieDetailContentCredit extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContentCredit({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 50,
        ),
        child: Text(
          movie?.overview ?? '',
          style: TextStyle(
            fontSize: 14,
            //*height -> vai dar espaçamento entre as linhas (sem usar padding)
            height: 1.3
          ) ,
        ),
      ),
    );
  }
}
