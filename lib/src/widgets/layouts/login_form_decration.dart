import 'package:flutter/material.dart';

class LoginInputDecration extends StatelessWidget {
  final FormFieldValidator validator;
  final TextEditingController controller;
  final String placeHolder;
  LoginInputDecration({this.validator, this.controller, @required this.placeHolder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: placeHolder,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }
}
