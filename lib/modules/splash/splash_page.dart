import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vhs_filmes/shared/themes/app_imags.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height,
          //* width: Get.width, -> substitui o MediaQuery abaixo( ele é a mesma coisa que o mediaquery, porém com menos escrita)
          // width: MediaQuery.of(context).size.width,
          //* height: Get.height -> substitui o MediaQuery abaixo( ele é a mesma coisa que o mediaquery, porém com menos escrita)
          // height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.background,
                ),
                fit: BoxFit.cover),
          ),
          child: Image.asset(AppImages.logo),
        ),
      ),
    );
  }
}