import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:vhs_filmes/modules/login/login_controller.dart';
import 'package:vhs_filmes/shared/themes/app_imags.dart';

class LoginPage extends GetView<LoginController> {
  //*Com o binding lazy, agora precisamos instanciar a controller !!
  //*podemos fazer da forma abaixo ou colocando diretamente no lugar o 'StatelessWidget' como o 'GetView' que faz a mesma função que aqui
  // final controller = Get.find<LoginController>();
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //* alignment to dizendo que a toda a stack vai ter o alignment
        alignment: Alignment.center,
        children: [
          //*Adicionando a imagem de fundo
          Image.asset(
            AppImages.background,
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          //*Adicionando um sombreamento por cima da imagem
          Container(color: Colors.black.withOpacity(0.2)),
          //*Adicionando o logo
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Column(
              //* colocamos um Column para que ao colocar o botão ele não fica acima do logo (por conta do alignment que colocamos na stack)
              //* com o column o botao vai ficar em baixo do logo
              children: [
                Image.asset(
                  AppImages.logo,
                ),
                const SizedBox(
                  height: 50,
                ),
                //*Adicionando o botão (usamos um package: https://pub.dev/packages/flutter_signin_button)
                //*SignInButton -> repare que não conseguimos aumentar o tamanho desse botão
                //* para isso iremos envolve-lo em um SizedBox para poder aumenta-lo
                SizedBox(
                  //? .9 -> multiplicando por 90%
                  width: Get.width * .6,
                  height: 42,
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () => controller.loginGoogle(),
                    text: 'Entrar com o google',
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width * .6,
                  height: 42,
                  child: SignInButton(
                    Buttons.Facebook,
                    onPressed: () {
                      controller.loginFacebook();
                    },
                    text: 'Entrar com o facebook',
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                //* Como eu adicionei a string como RxString no controller (para ela começar a ser reativa, observavel)
                //*E Essa classe aqui do LoginPage é 'Stateless' eu preciso adicionar o Obx
                //*O Obx vai tornar reativo (como se fosse um statefull) somente o que eu coloco dentro dele
                //* resumindo ele fica 'escutando'(reativo, observavel) e fica rebuildando(atualizando somente esse pedaço do Obx)
                // const SizedBox(height: 50,),
                // Obx(() {
                //   return Text(
                //     controller.nome.value, style: TextStyle(fontSize: 50, color: Colors.white)
                //   );
                // })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
