import 'package:flutter/material.dart';

class CustomButton  extends StatelessWidget {
  const CustomButton ({Key? key, required this.text, required this.press}) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: press as void Function()?,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),

            ),
          ),

          child: Text(text!),
        )

    );
  }
}