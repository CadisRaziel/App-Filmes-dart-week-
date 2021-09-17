// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vhs_filmes/modules/movies/movie_controller.dart';
import 'package:vhs_filmes/shared/themes/app_imags.dart';

class MoviesHeader extends GetView<MovieController> {
  const MoviesHeader({Key? key}) : super(key: key);

  //? Widget que vai conter nossa imagemPesquisa e nosso campo para pesquisar um filme

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      //*height 196 -> para a imagem 'imagePesquisa.png'
      height: 196,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            //*Para a imagem ficar certinha pegando a tela toda na largura
            width: Get.width,
            child: Image.asset(
              AppImages.imagePesquisa,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            //*Para o container ter 90% do tamanho da tela
            width: Get.width * .9,
            padding: EdgeInsets.only(bottom: 20),
            child: TextField(
              //*aqui passamos o filtro
              onChanged: (value) => controller.filterByName(value),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  //*fillColor e filled -> background do textfield
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Procurar filmes',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  //*contentPadding -> tira o pading de dentro do textfield
                  contentPadding: EdgeInsets.zero,
                  //*floatingLabelBehavior -> never vai tirar a animação de quando eu clico no textfield ele manda o 'Procurar filmes' para cima
                  floatingLabelBehavior: FloatingLabelBehavior.never),
            ),
          )
        ],
      ),
    );
  }
}
