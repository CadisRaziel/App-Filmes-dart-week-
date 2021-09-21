// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:vhs_filmes/modules/movies/movie_controller.dart';
import 'package:vhs_filmes/modules/movies/widgets/filter_tag.dart';

class MoviesFilters extends GetView<MovieController> {
  const MoviesFilters({Key? key}) : super(key: key);

  //? Aqui teremos os filtros

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () {
            return Row(
              children: controller.genresGenero
                  .map(
                    (genero) => FilterTag( 
                      model: genero,
                      onPressed: () {
                        //*Filtro de tags
                        controller.filterByGenero(genero);
                      },
                      selected: controller.genreSelected.value?.id == genero.id,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
