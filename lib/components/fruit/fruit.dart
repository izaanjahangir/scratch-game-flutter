import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class Fruit extends StatefulWidget {
  final double width;

  Fruit({@required this.width});

  @override
  _FruitState createState() => _FruitState();
}

class _FruitState extends State<Fruit> {
  bool isScratched = false;
  double scratchedPercentage = 0;
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scratcher(
        accuracy: ScratchAccuracy.medium,
        enabled: !isScratched,
        onChange: (value) {
          setState(() {
            scratchedPercentage = value;
          });
        },
        brushSize: widget.width * 0.05,
        threshold: 70,
        image: Image.asset("assets/images/scratch-here.jpeg"),
        onThreshold: () {
          setState(() {
            isScratched = true;
          });

          new Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              opacity = 1;
            });
          });
        },
        child: Container(
            width: widget.width * 0.45,
            height: widget.width * 0.45,
            child: isScratched
                ? AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 1),
                    child: Image.asset("assets/images/apple.png"))
                : Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Scratched",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            scratchedPercentage.toStringAsFixed(0) + "%",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
