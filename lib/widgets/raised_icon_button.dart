import 'package:flutter/material.dart';

class RaisedIconButton extends StatelessWidget {

  RaisedIconButton(this.icon, this.onPressed, this.color, this.size);

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final double padding = 5;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: size-2*padding)
        ],
      ),
    );
  }
}