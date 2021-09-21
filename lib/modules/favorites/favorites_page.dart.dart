import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vhs_filmes/modules/favorites/favorites_controller.dart';
import 'package:vhs_filmes/shared/UI/widgets/movie_card.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        //*automaticallyImplyLeading -> ele não coloca o icone de back
        automaticallyImplyLeading: false,
        title: const Text('Meus favoritos'),
        centerTitle: true,
        elevation: 0,
      ),
      // ignore: prefer_const_constructors
      body: Obx(
        () {
          return SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              //*Wrap -> como se fosse uma column
              //*a unica diferença é que quando ele chega no final da tela ele quebra linha
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: controller.movies
                    .map(
                      (movie) => MovieCard(
                        movie: movie,
                        favoriteCallBack: () => controller.removeFavorite(movie),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
