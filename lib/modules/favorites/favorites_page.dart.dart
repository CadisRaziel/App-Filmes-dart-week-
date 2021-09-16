import 'package:flutter/material.dart';
    
class FavoritesPage extends StatelessWidget {

  const FavoritesPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(    
      appBar: AppBar(
        //*automaticallyImplyLeading -> ele não coloca o icone de back  
        automaticallyImplyLeading: false,
        title: const Text('Meus favoritos'),
        centerTitle: true,
        elevation: 0,
      ),
      // ignore: prefer_const_constructors
      body: Center(child: const Text('Estou nos favoritos'))
    );
  }
}