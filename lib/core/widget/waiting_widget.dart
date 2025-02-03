import 'package:flutter/material.dart';
import '../styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({  this.size=100,Key? key}) : super(key: key);
final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:

        LoadingAnimationWidget.fourRotatingDots(
          color: Styles.colorPrimary, size: size,
          // size: 200,
        )

        // CircularProgressIndicator(),
      ),
    );
  }
}
