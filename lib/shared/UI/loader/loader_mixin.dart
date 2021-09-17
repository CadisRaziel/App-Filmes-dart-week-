import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const spinkit = SpinKitThreeBounce(
  color: Colors.white,
  size: 30.0,
);

mixin LoaderMixin on GetxController {
  //*Esse mixin só vai poder ser usado com o 'GetxController'
  void loaderListener(RxBool loaderRx) {
    //*Preciso tipa-lo como 'bool' pois o loader será um bool
    ever<bool>(loaderRx, (loading) async {
      if (loading) {
        await Get.dialog(
          const Center(child: spinkit),
          //*barrierDismissible -> Como false ele bloqueia, ele bloqueia quando eu clicar fora do loading ele não fecha o modal, ele trava na tela o loading
          //*Porque isso? se o usuario conseguir pausar o loading, ele pode ter acesso a botões que não queremos que ele tenha acesso até terminar de processar
          barrierDismissible: false
        );
      } else {
        //*Lembre-se back é igual o dispose
        Get.back();
      }
    });
  }
}

//*RxBool -> lembrese-se Rx deixa observavel
//*ever -> vai executar alguma função todas as vezes, sempre!