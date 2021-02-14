import 'package:flutter/material.dart';

class BorderDecoration extends StatelessWidget {

  const BorderDecoration(
      {this.validator,
      this.controller,
      @required this.placeHolder,
      this.onChanged});

  final FormFieldValidator validator;
  final TextEditingController controller;
  final String placeHolder;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: placeHolder, border: const OutlineInputBorder()),
        validator: validator,
        controller: controller,
        onChanged: onChanged as Function(dynamic),
      ),
    );
  }
}
