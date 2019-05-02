import 'package:bug_mobile_controller/widgets/controller_partials/controller_button.dart';
import 'package:bug_mobile_controller/widgets/expanded_flex_spacer.dart';
import 'package:flutter/material.dart';

class ControllerMid extends StatelessWidget {

  ControllerMid(this.imageAssetKey, this.onSelect, this.onStart);

  final VoidCallback onSelect;
  final VoidCallback onStart;
  final String imageAssetKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(imageAssetKey),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/image/bug.png'),
                    fit: BoxFit.scaleDown,
                  ),
                )
              )
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ControllerButton(Icons.shuffle, onSelect),
                  ExpandedFlexSpacer(1),                          
                  ControllerButton(Icons.play_circle_filled, onStart)
                ]
              )
            )
          ]
        )
      ),
    );
  }
}