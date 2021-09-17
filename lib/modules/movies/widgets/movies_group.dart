import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:vhs_filmes/models/movie_model.dart';
import 'package:vhs_filmes/shared/UI/widgets/movie_card.dart';

class MoviesGroup extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;

  const MoviesGroup({
    Key? key,
    required this.title,
    required this.movies,
  }) : super(key: key);

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
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              //*Para que o tamanho da listView seja 280
              height: 280,
              //*Obs pois ela vai fica atualizando !
              child: Obx(() {
                return ListView.builder(
                  //*shrinkWrap -> tenho um Column dinamico com um listview dinamico, para nao dar erro eu coloco esse atributo
                  //*com isso o listview sera recalculado toda vez que ele for montado
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: movies[index],
                    );
                  },
                );
              })),
        ],
      ),
    );
  }
}
