import 'package:flutter/material.dart';

class RaisedIconButton extends StatelessWidget {

  const RaisedIconButton({
    Key key,
    this.icon,
    @required this.onPressed,
    @required this.color,
    @required this.size,
    this.text
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final double padding = 5;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      padding: EdgeInsets.all(padding),
      child: Stack(children: <Widget>[
        Icon(icon, size: size-2*padding),
        Container(
          width: size-2*padding,
          height: size-2*padding,
          // color: Colors.blue,
          child: Center(child:
            Text((text != null ? text : ''),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size-2*padding)
            )
          )
        )
      ],),
    );
  }
}