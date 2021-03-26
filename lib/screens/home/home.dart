import 'package:flutter/material.dart';
import "package:scratcher_game/components/fruit/fruit.dart";
import "package:scratcher_game/screens/home/header.dart";
import "package:flutter/cupertino.dart";
import "package:scratcher_game/models/fruit.dart" as model;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String difficulty = "easy";
  int leftTries = 0;
  List<model.Fruit> fruits = [];

  @override
  void initState() {
    super.initState();

    loadGame();
  }

  loadGame() {
    final localDiff = difficulty;

    setState(() {
      difficulty = null;
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

    newFruits.shuffle();

    setState(() {
      difficulty = "easy";
      fruits = newFruits;
      leftTries = 2;
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

    newFruits.shuffle();

    setState(() {
      difficulty = "normal";
      fruits = newFruits;
      leftTries = 3;
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

    handleScratched(scatchedItem) {
      if (scatchedItem.id == "apple") {
        print("You won");
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (difficulty != null)
                    GridView.count(
                      physics: new NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: difficulty != "easy" ? 3 : 2,
                      children: fruits
                          .map((item) => Fruit(
                              onScratched: handleScratched,
                              brushSize: difficulty != "easy"
                                  ? width * 0.025
                                  : width * 0.05,
                              cardWidth: difficulty != "easy"
                                  ? width * 0.3
                                  : width * 0.4,
                              item: item))
                          .toList(),
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
