import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class Fruit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      child: Scratcher(
        brushSize: width * 0.05,
        threshold: 30,
        image: Image.asset("assets/images/scratch-here.jpeg"),
        onChange: (value) => print("Scratch progress: $value%"),
        onThreshold: () => print("Threshold reached, you won!"),
        child: Container(
            width: width * 0.45,
            height: width * 0.45,
            child: Image.asset("assets/images/apple.png")),
      ),
    );
  }
}
