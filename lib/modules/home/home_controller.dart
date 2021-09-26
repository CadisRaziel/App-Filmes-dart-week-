// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:vhs_filmes/services/login/login_service.dart';

class HomeController extends GetxController { 

  static const NAVIGATOR_KEY = 1;
  static const INDEX_PAGE_EXIT = 2;
  final LoginService _loginService; 

  //*Esse controller é para chamar nossa controller e não a service de uma vez(nos da mais controle)
  HomeController({
    required LoginService loginService
  }) : _loginService = loginService;

  //*Porque esse array, pelo motivo dele ter index, ou seja o 0(movies), 1(favories)
  //*Caso tiver mais icones é só eu adicionar a rota aqui dentro do array
  final _pages = ['/movies', '/favorites'];
  

  //*Para o icone mudar de cor, vamos colocar essa variavel observavel
  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

  void goToPage(int page) {
    _pageIndex(page);
    if(page == INDEX_PAGE_EXIT) {
       _loginService.logoutFacebook();
    } else if(page == INDEX_PAGE_EXIT) {
      _loginService.logoutFacebook();    
    } else {
        //*e aqui passamos o indice para ele
      Get.offNamed(_pages[page], id: NAVIGATOR_KEY);
    }
  }
}