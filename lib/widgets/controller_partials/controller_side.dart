import 'package:bug_mobile_controller/widgets/controller_partials/controller_button.dart';
import 'package:bug_mobile_controller/widgets/expanded_flex_spacer.dart';
import 'package:flutter/material.dart';

class ControllerSide extends StatelessWidget {

  ControllerSide(this.onTopPressed, this.onBottomPressed,
    this.onLeftPressed, this.onRightPressed,
    this.imageAssetKey);

  final VoidCallback onTopPressed;
  final VoidCallback onBottomPressed;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;
  final String imageAssetKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(imageAssetKey),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Contains up button
            Expanded(
              flex: 1,
              child: Container(
                child: Row(children: <Widget>[ // Cells in the grid
                  ExpandedFlexSpacer(1),                          
                  ControllerButton(Icons.keyboard_arrow_up, onTopPressed),
                  ExpandedFlexSpacer(1),       
                ])
              ),
            ),

            // Contains button left and button right
            Expanded(
              flex: 1,
              child: Container(
                child: Row(children: <Widget>[ // Cells in the grid
                  ControllerButton(Icons.keyboard_arrow_left, onLeftPressed),
                  ExpandedFlexSpacer(1),
                  ControllerButton(Icons.keyboard_arrow_right, onRightPressed),
                ])
              ),
            ),

            // Contains only the down button
            Expanded(
              flex: 1,
              child: Container(
                child: Row(children: <Widget>[ // Cells in the grid
                  ExpandedFlexSpacer(1),                          
                  ControllerButton(Icons.keyboard_arrow_down, onBottomPressed),
                  ExpandedFlexSpacer(1),       
                ])
              ),
            ),

          ]
        )
      )
    );
  }
}