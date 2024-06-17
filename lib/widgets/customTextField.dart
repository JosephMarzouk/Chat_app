import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, this.hintText, this.onChanged,this.obscureText=false});

  void Function(String)? onChanged;
  final String? hintText;
  bool ?obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if(data!.isEmpty)
        {
          return'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        focusColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white),),
       hintStyle: const TextStyle(color: Colors.white), 
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
