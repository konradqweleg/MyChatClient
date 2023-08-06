import 'package:flutter/material.dart';
import '../resources/image_resources.dart';

class BigAppLogo extends StatelessWidget {
  static const imageDimension = 250.0;

  const BigAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(ImageResources.logoApp),
      width: imageDimension,
      height: imageDimension,
    );
  }

}
