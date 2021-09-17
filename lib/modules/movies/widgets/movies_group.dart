import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vhs_filmes/shared/UI/widgets/movie_card.dart';

class MoviesGroup extends StatelessWidget {
  final String title;

  const MoviesGroup({
    Key? key,
    required this.title,
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
            child: ListView.builder(
                //*shrinkWrap -> tenho um Column dinamico com um listview dinamico, para nao dar erro eu coloco esse atributo
                //*com isso o listview sera recalculado toda vez que ele for montado
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MovieCard();
                }),
          ),
        ],
      ),
    );
  }
}
