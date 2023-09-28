import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  final TextEditingController controller;
  final String texthint;
  final String? Function(String?)? validator;
  Widget? prefixIcon;

   MyForm({super.key,
    required this.controller,
    required this.texthint,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 56,
        width: 330,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:Border.all(
            width: 1,
            color:Color(0xFFDADADA),
          ),
          color:Color(0xFFF7F8F9),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: texthint,
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            fillColor: Colors.white,
            focusColor: Colors.white,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            prefixIcon: prefixIcon,
          ),
          validator: validator,
        ),
    );
  }
}
