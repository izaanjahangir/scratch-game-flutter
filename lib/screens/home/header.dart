import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Function onChipPress;
  final int leftTries;
  final String difficulty;

  Header(
      {@required this.onChipPress,
      @required this.leftTries,
      @required this.difficulty});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: height * 0.075,
      color: Color.fromRGBO(0, 0, 0, 0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16),
              text: 'Tries Left: ',
              children: <TextSpan>[
                TextSpan(
                    text: leftTries.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ChipButton(
            label: difficulty,
            onPress: onChipPress,
          )
        ],
      ),
    );
  }
}

class ChipButton extends StatelessWidget {
  final String label;
  final Function onPress;

  ChipButton({@required this.label, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPress,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: height * 0.02, vertical: height * 0.005),
            child: Row(
              children: [
                if (label != null)
                  Text(
                    label,
                    style: TextStyle(fontSize: 14),
                  ),
                Icon(
                  Icons.arrow_drop_down,
                  size: height * 0.03,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
