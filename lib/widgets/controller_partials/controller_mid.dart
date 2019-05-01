import 'package:flutter/material.dart';

class ControllerMid extends StatelessWidget {

  ControllerMid(this.imageAssetKey);
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
      ),
    );
  }
}