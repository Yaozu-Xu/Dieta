import 'package:flutter/material.dart';

class LoginInputDecration extends StatelessWidget {
  final FormFieldValidator validator;
  final TextEditingController controller;
  final Function onChanged;
  final String placeHolder;
  final bool obscureText;
  LoginInputDecration({
    this.validator,
    this.controller,
    this.onChanged,
    this.obscureText,
    @required this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: TextFormField(
          obscureText: this.obscureText ?? false,
          decoration: InputDecoration(
              hintText: placeHolder,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 1.0)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[300], width: 1.0)),  
          ),      
          validator: validator,
          controller: controller,
          onChanged: onChanged),
    );
  }
}
