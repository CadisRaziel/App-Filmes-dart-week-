// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vhs_filmes/models/genre_model.dart';
import 'package:vhs_filmes/shared/themes/app_color_extension.dart';

class FilterTag extends StatelessWidget {
  final GenreModel model;
  final bool selected;
  final VoidCallback onPressed;

  const FilterTag({
    Key? key,
    required this.model,
    this.selected = false,
    required this.onPressed,
  }) : super(key: key);

  //? Tags de filtros

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        //*constraints dou um tamanho minimo de altura e largura (para se adptar)
        constraints: BoxConstraints(
          minWidth: 100,
          minHeight: 30,
        ),
        decoration: BoxDecoration(
          color: selected ?  context.themeRed : Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            model.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}


//*Padding -> espaços internos
//*Margin -> espaços de fora