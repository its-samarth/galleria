import 'package:flutter/material.dart';
import 'dart:ui';

class LoadingBlurOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,  // Adjust the width to your preference
        height: 40, // Adjust the height to your preference
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
