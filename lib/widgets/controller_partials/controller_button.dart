import 'package:bug_mobile_controller/widgets/raised_icon_button.dart';
import 'package:flutter/material.dart';

class ControllerButton extends StatelessWidget {

  const ControllerButton({
    Key key,
    this.icon,
    @required this.onPressed,
    this.text
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final double padding = 5;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: new LayoutBuilder(
          builder: (context, constraint) {
            return RaisedIconButton(icon: icon, onPressed: onPressed, color: Colors.redAccent, size: constraint.biggest.width, text: text);
          }
        ),
      ),
    );
  }
}