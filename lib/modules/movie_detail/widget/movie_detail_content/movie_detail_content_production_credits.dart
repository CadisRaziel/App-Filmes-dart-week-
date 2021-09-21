// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vhs_filmes/models/movie_detail_model.dart';

class MovieDetailContentProductionCredits extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContentProductionCredits({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 5),
      child: RichText(
        //*Se eu coloca-se uma row com 2 text daria certo, porém o TextSpan foi criado justamente para isso
        //*Colocar dois textos de forma estilizada diferente um do outro na mesma linha
        text: TextSpan(
            text: 'Compania(s) produtora(s): ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextSpan(
                text: movie?.productionsCompanies.join(', ') ?? '',
                style: TextStyle( 
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF222222),
                ),
              )
            ]),
      ),
    );
  }
}
