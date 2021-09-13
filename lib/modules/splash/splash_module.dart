
// ignore_for_file: prefer_const_constructors

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vhs_filmes/application/modules/module.dart';
import 'package:vhs_filmes/modules/splash/splash_page.dart';

class SplashModule extends Module{
  @override
  List<GetPage> routers = [
    GetPage(name: '/', page: () => SplashPage())
  ];
  
}