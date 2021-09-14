import 'package:flutter/material.dart';


class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String text;
  final IconData icon;
  const GoogleLoginButton({
    Key? key,
    required this.onTap,
    this.image = "",
    required this.text,
    this.icon = Icons.ac_unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: const Border.fromBorderSide(
            BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image.isEmpty ? Icon(icon) : Image.asset(image),
                  const SizedBox(
                    width: 16
                  ),
                  //* Traço entre o logo e o texto 'Entrar com Google'
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            //* Texto 'Entrar com google', com alinhamento do logo do goole junto por isso o flex 3
            Expanded(
              flex: 3,
              child: Row(                
                mainAxisAlignment: MainAxisAlignment.center,                
                children: [                  
                  Text(text,),
                  const SizedBox(width: 50,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}