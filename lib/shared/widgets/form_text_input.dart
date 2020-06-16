import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

/// This is a wrapper for a TextFormField. It add
/// some nice graphics effects
class FormTextInput extends StatelessWidget {
  const FormTextInput({
    Key key, 
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.labelText,
    this.hintText,
    this.color,
    @required this.controller,
    @required this.validator,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Color color;

  final bool obscureText;
  final TextEditingController controller;
  final String Function(String) validator;

  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: color ?? randomMaterialColor(),
                  width: 3
                )
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: color ?? randomMaterialColor(),
                  width: 3
                )
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 3
                )
              ),
              labelText: labelText, 
              hintText: hintText, 
            ),
        validator: validator,
    );
  }
}