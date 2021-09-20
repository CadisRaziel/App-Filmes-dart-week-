// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import 'package:vhs_filmes/models/movie_model.dart';
import 'package:vhs_filmes/shared/icon/vhs_films_icons.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  //*Formatando data com o package 'intl', vamos adicionar somente o ano
  final dateFormat = DateFormat('y');

  MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          '/movie/detail',
          //*Argumento para pegar os detalhes do movie em que clicar (ou seja ele ao clicar no filme
          //* ele vai buscar o id dele e apresentar ja na proxima tela as caracteristicas que eu definir)
          arguments: movie.id
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 158,
        height: 280,
        child: Stack(
          children: [
            //*Column para a imagem e o titulo ficar um abaixo do outro, repare que esta dentro da stack
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    //*ClipRRect -> alternativa ao container para por bordas em fotos etc...
                    borderRadius: BorderRadius.circular(20),
                    //*clipBehavior-> tira o serrilhado da borda
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(movie.posterPath,
                        width: 148, height: 184, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  //*Overflow -> se o texto for muito longo ele vai colocar '...', por isso o 'ellipsis'
                  //*porém só vai colocar após ter 2 quebras de linhas como defini !
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  //*fazendo a conversão para aparecer somente o ano
                  dateFormat.format(
                    DateTime.parse(movie.releaseData),
                  ),
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ],
            ),
            //*Adicionando o botão de coração para por favorito
            Positioned(
              //*Positioned para eu colocar ele do lado direito embaixo
              bottom: 70,
              right: -5,
              child: Material(
                //*Material -> para deixar ele com elevation e com o circulo redondo em volta dele
                elevation: 5,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                    height: 30,
                    child: IconButton(
                      iconSize: 13,
                      icon: Icon(
                        VhsFilms.heart_empty,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
