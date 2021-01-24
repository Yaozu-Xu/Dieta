import 'package:flutter/material.dart';

class BorderDecoration extends StatelessWidget {

  final FormFieldValidator validator;
  final TextEditingController controller;
  final String placeHolder;
  final Function onChanged;
  BorderDecoration({this.validator, this.controller, @required this.placeHolder, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 200),
      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: placeHolder,
          border: OutlineInputBorder()
        ),
        validator: validator,
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}