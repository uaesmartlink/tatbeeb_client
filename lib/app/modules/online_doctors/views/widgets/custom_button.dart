

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final Function onTap;
  final String text;
  final Color color;

  CustomButton({Key?key,required this.onTap,required this.text,required this.color});

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
          padding: EdgeInsets.all(12),
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: color,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }
}