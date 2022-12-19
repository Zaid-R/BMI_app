import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  int ? age ;
  final double BMI ;
  final bool male ;

  final Color white = Colors.white;

  final textStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  ResultPage({super.key, required this.age, required this.BMI, required this.male});

  String get healthiness {
    return BMI < 18.5
        ? 'Underweight'
        : BMI <= 24.9
            ? 'Normal'
            : BMI <= 29.9
                ? 'Overweight'
                : 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Result',
            style: TextStyle(color: white),
          ),
        ),
        body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Text('Gender: ' + (male ? 'Male' : 'Female'), style: textStyle),
            Text(
                'Reslut: ' + BMI.toStringAsFixed(1),
                style: textStyle),
            Text('Healthiness: ' + healthiness, style: textStyle,textAlign: TextAlign.center,),
            Text('Age: ' + age.toString(), style: textStyle),
                    ]),
                  )),
      );
  }
}
