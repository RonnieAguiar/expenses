import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AdaptativeButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(label),
            style: ButtonStyle(

              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary),
              textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            ),
          );
  }
}
