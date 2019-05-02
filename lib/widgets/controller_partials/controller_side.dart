import 'package:bug_mobile_controller/widgets/controller_partials/controller_button.dart';
import 'package:bug_mobile_controller/widgets/expanded_flex_spacer.dart';
import 'package:flutter/material.dart';

class ControllerSide extends StatelessWidget {

  const ControllerSide({
    Key key,
    @required this.onTopPressed,
    @required this.onBottomPressed,
    @required this.onLeftPressed,
    @required this.onRightPressed,
    @required this.imageAssetKey,
    this.useLetters = false
  }) : super(key: key);

  final VoidCallback onTopPressed;
  final VoidCallback onBottomPressed;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;
  final String imageAssetKey;
  final bool useLetters;

  @override
  Widget build(BuildContext context) {
    List<ControllerButton> controls;

    if (useLetters) {
      controls = [
        ControllerButton(text: 'X', onPressed: onTopPressed),
        ControllerButton(text: 'Y', onPressed: onLeftPressed),
        ControllerButton(text: 'A', onPressed: onRightPressed),
        ControllerButton(text: 'B', onPressed: onBottomPressed),
      ];
    } else {
      controls = [
        ControllerButton(icon: Icons.keyboard_arrow_up, onPressed: onTopPressed),
        ControllerButton(icon: Icons.keyboard_arrow_left, onPressed: onLeftPressed),
        ControllerButton(icon: Icons.keyboard_arrow_right, onPressed: onRightPressed),
        ControllerButton(icon: Icons.keyboard_arrow_down, onPressed: onBottomPressed),
      ];
    }

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
                  controls[0],
                  ExpandedFlexSpacer(1),       
                ])
              ),
            ),

            // Contains button left and button right
            Expanded(
              flex: 1,
              child: Container(
                child: Row(children: <Widget>[ // Cells in the grid
                  controls[1],
                  ExpandedFlexSpacer(1),
                  controls[2],
                ])
              ),
            ),

            // Contains only the down button
            Expanded(
              flex: 1,
              child: Container(
                child: Row(children: <Widget>[ // Cells in the grid
                  ExpandedFlexSpacer(1),
                  controls[3],
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