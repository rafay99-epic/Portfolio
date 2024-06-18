// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final int maxLines;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool passwordText;
  final bool peekpassword;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.maxLines = 1,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordText = false,
    this.peekpassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.peekpassword;
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              spreadRadius: 1,
              blurRadius: 0,
              // offset: const Offset(1, 1),
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          obscureText: widget.passwordText ? !_passwordVisible : false,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon: widget.passwordText
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
