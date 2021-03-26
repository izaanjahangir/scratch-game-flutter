import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import "package:scratcher_game/models/fruit.dart" as model;

class Fruit extends StatefulWidget {
  final model.Fruit item;
  final double brushSize;
  final double cardWidth;
  final Function onScratched;

  Fruit(
      {@required this.item,
      @required this.cardWidth,
      @required this.brushSize,
      @required this.onScratched});

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
        brushSize: widget.brushSize,
        threshold: 60,
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

          widget.onScratched(widget.item);
        },
        child: Container(
            width: widget.cardWidth,
            height: widget.cardWidth,
            child: isScratched
                ? AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 1),
                    child: Image.asset(widget.item.image))
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
