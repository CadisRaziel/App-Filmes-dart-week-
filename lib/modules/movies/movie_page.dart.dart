import 'package:flutter/material.dart';
    
class MoviePage extends StatelessWidget {

  const MoviePage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Center(child: const Text('Estou nos filmes'))    
    );
  }
}