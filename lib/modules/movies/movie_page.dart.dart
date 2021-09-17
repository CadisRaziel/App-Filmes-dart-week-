// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vhs_filmes/modules/movies/widgets/movies_filters.dart.dart';
import 'package:vhs_filmes/modules/movies/widgets/movies_group.dart';
import 'package:vhs_filmes/modules/movies/widgets/movies_header.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          MoviesHeader(),
          MoviesFilters(),
          MoviesGroup(title: 'Mais populares',),
          MoviesGroup(title: 'Top filmes',),
        ],
      ),
    );
  }
}
