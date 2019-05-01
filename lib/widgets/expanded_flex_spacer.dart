import 'package:flutter/material.dart';

class ExpandedFlexSpacer extends StatelessWidget {

  ExpandedFlexSpacer(this.weight);

  final int weight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: weight,
      child: Container(),
    );
  }
}