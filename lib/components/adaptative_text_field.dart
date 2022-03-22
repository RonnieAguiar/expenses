import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keybordType;
  final TextInputAction textInputAction;
  final Function(String)? submitForm;

  const AdaptativeTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.keybordType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.submitForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
                placeholder: label,
                controller: controller,
                keyboardType: keybordType,
                textInputAction: textInputAction,
                onSubmitted: (_) => submitForm,
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 12,
                )),
          )
        : TextField(
            decoration: InputDecoration(labelText: label),
            controller: controller,
            keyboardType: keybordType,
            textInputAction: textInputAction,
            onSubmitted: (_) => submitForm,
          );
  }
}
