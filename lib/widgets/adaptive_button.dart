import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
final String text;
final VoidCallback handler;

AdaptiveButton(this.text,this.handler);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isIOS
          ? CupertinoButton(child: Expanded(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple[600]
          ),
        ),
      ), onPressed: handler)
          : TextButton(
        onPressed: handler,
        child: Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700]
            ),
          ),
        ),
      ),
    );
  }
}