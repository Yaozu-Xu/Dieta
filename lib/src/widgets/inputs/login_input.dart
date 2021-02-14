import 'package:flutter/material.dart';

class LoginInputDecration extends StatelessWidget {
  const LoginInputDecration({
    this.validator,
    this.controller,
    this.onChanged,
    this.obscureText,
    @required this.placeHolder,
  });

  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final Function onChanged;
  final String placeHolder;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: TextFormField(
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: placeHolder,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300])),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[300])),
          ),
          validator: validator,
          controller: controller,
          onChanged: onChanged as Function(String)),
    );
  }
}
