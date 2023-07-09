import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String? text, image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(
          flex: 2,
        ),
        Text(
          'Fashion Store',
          style: TextStyle(
              fontSize: 35,
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold),
        ),
        Text(text!),
        Spacer(),
        Image.asset(
          image!,
          height: 265,
          width: 235,
        )
      ],
    );
  }
}