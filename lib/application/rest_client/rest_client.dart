import 'package:get/get_connect.dart';

class RestClient extends GetConnect {
  
  RestClient() {
    //*Todos serviços da api que eu acessar, sera dessa url
    httpClient.baseUrl = 'https://api.themoviedb.org/3';
  }
}
