import 'package:flutter/material.dart';

class Gender extends StatelessWidget {
  final String gender;
  final IconData icon;
  final Function() function;
  final TextStyle titleStyle;
  Color color ;
  Gender(
      {super.key,
      required this.gender,
      required this.icon,
      required this.function,
      required this.titleStyle,
      required this.color});

  @override
  Widget build(Object context) => Expanded(
        child: InkWell(
          onTap: function,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 90,
                ),
                SizedBox(height: 10),
                Text(
                  gender,
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
      );
}
