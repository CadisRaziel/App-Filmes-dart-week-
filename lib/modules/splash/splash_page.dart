import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vhs_filmes/shared/themes/app_imags.dart';


class SplashPage extends StatelessWidget {

 const SplashPage({Key? key}) : super(key: key);

 //*SplashScreen

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
          child: Lottie.asset(AppImages.animacao2,),
          // child: RiveAnimation.network(AppImages.animacao3)
        ),
      ),
    );
  }
}