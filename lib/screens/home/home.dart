import 'package:flutter/material.dart';
import "package:scratcher_game/components/fruit/fruit.dart";
import "package:scratcher_game/screens/home/header.dart";
import "package:flutter/cupertino.dart";
import "package:scratcher_game/models/fruit.dart" as model;
import 'package:rflutter_alert/rflutter_alert.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String difficulty = "easy";
  int leftTries = 0;
  bool isPlaying = false;
  bool showGrid = true;
  List<model.Fruit> fruits = [];

  @override
  void initState() {
    super.initState();

    loadGame();
  }

  loadGame() {
    final localDiff = difficulty;

    setState(() {
      showGrid = false;
    });

    new Future.delayed(const Duration(milliseconds: 100), () {
      if (localDiff == "easy") {
        loadEasy();
      }
      if (localDiff == "normal") {
        loadNormal();
      }
      if (localDiff == "hard") {
        loadHard();
      }
    });
  }

  loadEasy() {
    final List<model.Fruit> newFruits = [
      new model.Fruit("apple", "assets/images/apple.png"),
      new model.Fruit("banana", "assets/images/banana.png"),
      new model.Fruit("mango", "assets/images/mango.png"),
      new model.Fruit("pineapple", "assets/images/pineapple.png"),
    ];

    // newFruits.shuffle();

    setState(() {
      difficulty = "easy";
      fruits = newFruits;
      leftTries = 2;
      isPlaying = true;
      showGrid = true;
    });
  }

  loadNormal() {
    final List<model.Fruit> newFruits = [
      new model.Fruit("apple", "assets/images/apple.png"),
      new model.Fruit("banana", "assets/images/banana.png"),
      new model.Fruit("mango", "assets/images/mango.png"),
      new model.Fruit("pineapple", "assets/images/pineapple.png"),
      new model.Fruit("pomegranate", "assets/images/pomegranate.png"),
      new model.Fruit("strawberry", "assets/images/strawberry.png"),
    ];

    // newFruits.shuffle();

    setState(() {
      difficulty = "normal";
      fruits = newFruits;
      leftTries = 3;
      isPlaying = true;
      showGrid = true;
    });
  }

  loadHard() {
    final List<model.Fruit> newFruits = [
      new model.Fruit("apple", "assets/images/apple.png"),
      new model.Fruit("banana", "assets/images/banana.png"),
      new model.Fruit("mango", "assets/images/mango.png"),
      new model.Fruit("pineapple", "assets/images/pineapple.png"),
      new model.Fruit("pomegranate", "assets/images/pomegranate.png"),
      new model.Fruit("strawberry", "assets/images/strawberry.png"),
    ];

    // newFruits.shuffle();

    setState(() {
      difficulty = "hard";
      fruits = newFruits;
      leftTries = 2;
      isPlaying = true;
      showGrid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    showDifficultySelectModal() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Select Difficulty'),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Easy'),
              onPressed: () {
                setState(() {
                  difficulty = "easy";
                  loadGame();
                });
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Normal'),
              onPressed: () {
                setState(() {
                  difficulty = "normal";
                  loadGame();
                });
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Hard'),
              onPressed: () {
                setState(() {
                  difficulty = "hard";
                  loadGame();
                });
                Navigator.pop(context);
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    }

    showSuccess() {
      Alert(
        style: AlertStyle(
          animationType: AnimationType.grow,
          isCloseButton: true,
          isOverlayTapDismiss: true,
          animationDuration: Duration(milliseconds: 500),
        ),
        context: context,
        type: AlertType.success,
        title: "You won!",
        desc: "Your doctor will stay away from you",
        buttons: [
          DialogButton(
            child: Text(
              "Play again",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              loadGame();
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();

      setState(() {
        isPlaying = false;
      });
    }

    showError() {
      Alert(
        style: AlertStyle(
          animationType: AnimationType.grow,
          isCloseButton: true,
          isOverlayTapDismiss: true,
          animationDuration: Duration(milliseconds: 500),
        ),
        context: context,
        type: AlertType.error,
        title: "You lose!",
        desc: "Your doctor is coming",
        buttons: [
          DialogButton(
            child: Text(
              "Play again",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              loadGame();
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();

      setState(() {
        isPlaying = false;
      });
    }

    handleScratched(scatchedItem) {
      if (scatchedItem.id == "apple") {
        showSuccess();
      } else {
        setState(() {
          leftTries = leftTries - 1;
        });

        if (leftTries == 0) {
          showError();
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(
                onChipPress: showDifficultySelectModal,
                leftTries: leftTries,
                difficulty: difficulty),
            Container(
              padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        OutlinedButton(
                            onPressed: loadGame, child: Text("Restart Game")),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "An Apple a day keeps a doctor away",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Find the apple",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Opacity(
                          opacity: isPlaying ? 0 : 1,
                          child: Text(
                            "Game is finished. Please restart",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: !isPlaying,
                    child: showGrid
                        ? GridView.count(
                            physics: new NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: difficulty != "easy" ? 3 : 2,
                            children: fruits
                                .map((item) => Fruit(
                                    onScratched: handleScratched,
                                    brushSize: difficulty != "easy"
                                        ? width * 0.04
                                        : width * 0.05,
                                    cardWidth: difficulty != "easy"
                                        ? width * 0.3
                                        : width * 0.4,
                                    item: item))
                                .toList(),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
