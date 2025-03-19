import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget({
    super.key,
    this.controller,
    this.fieldKey,
    this.isPasswordField,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType
  });

  @override
  State<FormContainerWidget> createState() => _formCOntainerWidgetState();
}

class _formCOntainerWidgetState extends State<FormContainerWidget> {

  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width : double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(10),
      ),
      child: new TextFormField(
        style: TextStyle(color: Colors.blue),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true? _obsecureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: new InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: (Colors.black45),

          ),
          // suffixIcon: new GestureDetector(
          //   onTap : () {
          //     setState(() {
          //       _obsecureText = !_obsecureText;
          //     });
          //   },
          //   child: widget.isPasswordField == true? Icon(_obsecureText ? Icons.visibility_off : Icons.visibility, color: _obsecureText == false ? Colors.blue : Colors.grey)
          // ),


          //



          suffixIcon: widget.isPasswordField == true
              ? GestureDetector(
            onTap: () {
              setState(() {
                _obsecureText = !_obsecureText;
              });
            },
            child: Icon(
              _obsecureText ? Icons.visibility_off : Icons.visibility,
              color: _obsecureText ? Colors.grey : Colors.blue,
            ),
          )
              : null, // No icon for non-password fields

        ),
      ),
    );
  }
}
