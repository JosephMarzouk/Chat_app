import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
    CustomButton({super.key, this.ontap, required this.text});
final String text;
 void Function()? ontap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap ,
      child: Container(
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 60,
                child: 
               Center(child: Text(text)),),
    );
  }
}