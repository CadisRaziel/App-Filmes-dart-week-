// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vhs_filmes/modules/favorites/favorites_binding.dart';
import 'package:vhs_filmes/modules/favorites/favorites_page.dart.dart';
import 'package:vhs_filmes/modules/home/home_controller.dart';
import 'package:vhs_filmes/modules/movies/movie_binding.dart';
import 'package:vhs_filmes/modules/movies/movie_page.dart.dart';
import 'package:vhs_filmes/shared/icon/vhs_films_icons.dart';
import 'package:vhs_filmes/shared/themes/app_color_extension.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Deixaremos o bottomNavigationBar observavel com o Obx
      //* Com isso ele vai ficar se rebuildando para ver se tem alteração, porém é somente ele (como definimos no obx)
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            //*selectedItemColor -> quando selecionado vai ter a cor que colocarmos aqui
            //*context.themeRed -> criamos uma classe de extension especial para as cores
            selectedItemColor: context.themeRed,
            //*unselectedItemColor -> quando nao tiver selecionado vai mudar para essa cor
            unselectedItemColor: Colors.grey,
            onTap: controller.goToPage,
            currentIndex: controller.pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.local_movies),
                label: 'Filmes',
              ),
              BottomNavigationBarItem(
                icon: Icon(VhsFilms.heart_empty),
                label: 'Favoritos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Sair',
              )
            ],
          );
        },
      ),
      body: Navigator(
        //*initialRoute -> por padrão é '/', precisamos mudar para o '/movies', como definindo ali em baixo
        initialRoute: '/movies',
        //*nestedKey -> para fazer a navegação no HomeController !!
        key: Get.nestedKey(HomeController.NAVIGATOR_KEY),
        //*onGenerateRoute -> responsavel por controlar a navegação
        onGenerateRoute: (settings) {
          if (settings.name == '/movies') {
            //*Precisa retornar um GetPageRoute
            return GetPageRoute(
              settings: settings,
              page: () => MoviePage(),
              binding: MovieBinding()
            );
          }

          if (settings.name == '/favorites') {
            //*Precisa retornar um GetPageRoute
            return GetPageRoute(
              settings: settings,
              page: () => FavoritesPage(),
              binding: FavoritesBinding()
            );
          }

          //*Se não vier nenhuma rota que conheco
          return null;
        },
      ),
    );
  }
}

//*Vamos utilizar o navigator 2.0 para gerenciar os 3 icones
//*Porque navigator 2.0, porque ele não altera a pagina toda do app
//*Ele só altera o conteudo dentro do body (sem que seja trocada de tela...)
//*Resumindo ao clicar no botao 'Filmes' ele vai apresentar os filmes (ele nao vai cria uma nova tela pra isso, vai mostrar nessa mesma tela de home)
//*Ao clicar no botão favorito ele vai alterar para tela de favoritos, porém dentro da home ainda
//*voce percebeu que ele nao vai criar uma nova tela ? ele vai criar um body para cada icon sem alterar as telas
//*Ele mantem a appbar e o bottomNavigator
//*Só é alterado o conteudo do body
