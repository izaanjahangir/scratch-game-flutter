import 'package:flutter/material.dart';
import "package:scratcher_game/components/fruit/fruit.dart";

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        // child: GridView.count(
        //   crossAxisCount: 2,
        //   children: List.generate(4, (index) {
        //     return Fruit();
        //   }),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
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
            GridView.count(
              physics: new NeverScrollableScrollPhysics(),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return Fruit();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
