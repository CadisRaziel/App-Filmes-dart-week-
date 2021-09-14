import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_card/animated_card.dart';
import 'package:vhs_filmes/shared/themes/app_imags.dart';
import 'package:vhs_filmes/shared/widgets/social_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              Image.asset(AppImages.logo),
              const SizedBox(height: 50,),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 15),
                  child: GoogleLoginButton(
                    image: AppImages.google,
                    text: "Entrar com Google",
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
