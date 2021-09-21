import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vhs_filmes/models/cast_model.dart';
import 'package:vhs_filmes/shared/themes/app_color_extension.dart';

class MovieCastContent extends StatelessWidget {
  final CastModel? cast;

  const MovieCastContent({Key? key, this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cast?.image ?? '',
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            cast?.name ?? '',
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            cast?.character ?? '',
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 12,
              color: context.themeGrey
            ),
          ),
        ],
      ),
    );
  }
}
