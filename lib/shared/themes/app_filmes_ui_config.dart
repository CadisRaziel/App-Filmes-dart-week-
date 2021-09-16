// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FilmesAppUiConfig {
  //*Lembre-se construtor privado impede que a classe seja instanciada 'var filmes = FilmesAppUiConfig();'
  FilmesAppUiConfig._();

  static String get title => 'Filmes app';
  static ThemeData get theme => ThemeData(
    //*Font de todo o app
      fontFamily: 'Metropolis',
        //* Todo Scaffold sera branco
        scaffoldBackgroundColor: Colors.white,
        //*Alterando o thema da appbar
        appBarTheme: AppBarTheme(
          //*Deixando o fundo branco da appbar
          backgroundColor: Colors.white,
          //*Deixando os icones da appbar preto
          iconTheme: IconThemeData(color: Colors.black),
          //*Alterando a cor do titulo do appbar
          titleTextStyle: TextStyle(
            color: Color(0xFF222222),
            //*Alterando a fonte do titulo
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
