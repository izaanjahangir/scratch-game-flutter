import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Function onChipPress;

  Header({@required this.onChipPress});

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
                    text: '2', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ChipButton(
            label: "Easy",
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
