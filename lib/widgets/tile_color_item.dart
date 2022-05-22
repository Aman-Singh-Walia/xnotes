import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileColorItem extends StatelessWidget {
  final String name;
  final int tileColor;
  final bool selected;
  const TileColorItem(
      {Key? key,
      required this.name,
      required this.tileColor,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontFamily: 'Varela', fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
              color: Color(tileColor),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  width: 4.0,
                  color:
                      selected ? CupertinoColors.activeBlue : Colors.black12)),
          child: const Icon(
            CupertinoIcons.circle_fill,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
