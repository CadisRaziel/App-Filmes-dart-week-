import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vhs_filmes/application/bindings/aplication_binding.dart';
import 'package:vhs_filmes/modules/home/home_module.dart';
import 'package:vhs_filmes/modules/login/login_module.dart';
import 'package:vhs_filmes/modules/splash/splash_module.dart';
import 'package:vhs_filmes/shared/themes/app_filmes_ui_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //*FilmesAppUiConfig.title, -> repare que eu criei uma classe de configuração para realizar o thema
      title:  FilmesAppUiConfig.title,
      initialBinding: AplicationBinding(),
      //*FilmesAppUiConfig.theme -> repare que eu criei uma classe de configuração para realizar o thema
      theme: FilmesAppUiConfig.theme,
      debugShowCheckedModeBanner: false,
      getPages: [
        //* porque os '...' porque ele vai pegar o array criado dentro de splashModule destruir ele, e criar dentro desse array getpages
        ...SplashModule().routers,
        ...LoginModule().routers,
        ...HomeModule().routers,
      ],
    );
  }
}