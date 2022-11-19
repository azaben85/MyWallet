import 'package:flutter/material.dart';

class ImageAsset extends StatelessWidget {
  String imageAsset;
  double width;
  double height;
  ImageAsset(this.imageAsset, {this.width = 0.0, this.height = 0.0, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/images/$imageAsset'),
    );
  }
}
