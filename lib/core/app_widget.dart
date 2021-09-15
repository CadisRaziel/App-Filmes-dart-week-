import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vhs_filmes/modules/login/login_module.dart';
import 'package:vhs_filmes/modules/splash/splash_module.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        //* porque os '...' porque ele vai pegar o array criado dentro de splashModule destruir ele, e criar dentro desse array getpages
        ...SplashModule().routers,
        ...LoginModule().routers,
      ],
    );
  }
}