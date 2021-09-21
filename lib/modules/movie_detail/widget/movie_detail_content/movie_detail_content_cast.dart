// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vhs_filmes/models/movie_detail_model.dart';
import 'package:vhs_filmes/modules/movie_detail/widget/movie_detail_content/movie_cast_content.dart';
import 'package:vhs_filmes/shared/themes/app_color_extension.dart';

class MovieDetailContentCast extends StatelessWidget {
  final MovieDetailModel? movie;

  //*Por ser algo simples, vamos colocar um observavel diretamente aqui na statelessWidget e não em uma controller
  //*é aquela setinha para baixo que apresenta e desapresenta algo
  final showPanel = false.obs;

  MovieDetailContentCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 0.5, color: context.themeGrey),
        //*ExpansionPanelList/ExpansionPanel -> é aquela setinha para baixo (quando voce clica mostra algo, quado voce clica novamente ela esconde algo)
        Obx(() {
          return ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            //* expansionCallback -> ao clicar ele vai chamar o 'isExpanded' e o 'toggle' fica alternando de true e false
            expansionCallback: (panelIndex, isExpanded) {
              //*Esse toggle é do rx do get, ele vai vai inverter o true e deixar como false
              showPanel.toggle();
            },
            children: [
              ExpansionPanel(
                //*canTapOnHeader -> se ele vai poder clicar no header para abrir o expanded(ou seja no titulo ou envolta do titulo) 'false' = não
                //*para abrir vai ter que clicar no icone apenas
                canTapOnHeader: false,
                //*isExpanded -> se ele vai inicia aberto ou fechado (true = aberto / false = fechado)
                isExpanded: showPanel.value,
                backgroundColor: Colors.white,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Elenco principal',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
                //*Body -> conteudo que vai aparecer ao clicar no icone de setinha
                body: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //*Para apresentar todos os atores
                    children: movie?.cast
                            .map((cast) => MovieCastContent(cast: cast))
                            .toList() ??
                        [],
                  ),
                ),
              ),
            ],
          );
        })
      ],
    );
  }
}
