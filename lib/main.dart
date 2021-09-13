import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:vhs_filmes/core/app_widget.dart';

void main() async {
  //* WidgetsFlutterBinding.ensureInitialized(); -> para iniciarlizar o flutter antes de rodar a aplicação
  //* para evitar problemas no firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  //* Configurando o 'remote config' do firebase (lembrando que ele é 1000x mais seguro que colcoar um .env aqui na aplicação)
  //* e é de graça, posso fazer com qualquer projeto (util para dados que não podem ser acessador por pessoas de fora e deixar longe de hackers)
  final remoteConfig = RemoteConfig.instance;
  remoteConfig.fetchAndActivate();
  runApp(const MyApp());
}
