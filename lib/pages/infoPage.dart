import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'resultPage.dart';
import '../classes/gender.dart';
import 'dart:math';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Color white = Colors.white;

  double height = 0.0;
  BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.blueGrey, borderRadius: BorderRadius.circular(10));

  TextEditingController weight = TextEditingController();
  bool gender = false; //true for male

  Color maleColor = Colors.blueGrey, femaleColor = Colors.blueGrey;
  DateTime? birthDate = null;

  void setGenderButtonColor(bool male) {
    setState(() {
      maleColor = male ? Colors.teal : Colors.blueGrey;
      femaleColor = male ? Colors.blueGrey : Colors.teal;
    });
  }

  void setGender(bool male) => setState(() {
        gender = male;
        setGenderButtonColor(gender);
      });

  int age = 0;
  calculateAge() {
    DateTime currentDate = DateTime.now();
    int month1 = currentDate.month;
    int month2 = birthDate!.month;
    setState(() {
      age = currentDate.year - birthDate!.year;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate!.day;
        if (day2 > day1) {
          age--;
        }
      }
    });
  }

  void pickBirthDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365 * 120)),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() => birthDate = value);
      calculateAge();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.headline1!;
    double screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Body Mass Index',
          style: TextStyle(color: white),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  //gender
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Gender(
                          gender: 'Male',
                          icon: Icons.male,
                          function: () => setGender(true),
                          titleStyle: titleStyle,
                          color: maleColor,
                        ),
                        Gender(
                          gender: 'Female',
                          icon: Icons.female,
                          function: () => setGender(false),
                          titleStyle: titleStyle,
                          color: femaleColor,
                        )
                      ],
                    ),
                  ),
                  //Height
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: containerDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Height', style: titleStyle),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(height.toStringAsFixed(0),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      color: white)),
                              Text(' cm',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ],
                          ),
                          Slider(
                            value: height,
                            onChanged: (x) => setState(() {
                              height = x.truncate().toDouble();
                            }),
                            min: 0,
                            max: 250,
                          )
                        ],
                      ),
                    ),
                  ),
                  ///////////////////Weight & age
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /////////////////Age
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            margin: EdgeInsets.all(10),
                            decoration: containerDecoration,
                            child: Column(
                              children: [
                                Text(
                                  "Birth date",
                                  style: titleStyle,
                                ),
                                SizedBox(
                                  height: screenHeight / 30,
                                ),
                                if (birthDate != null)
                                  Text(
                                    birthDate!.year.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: white),
                                  ),
                                if (birthDate != null)
                                  SizedBox(
                                    height: screenHeight / 30,
                                  ),
                                ElevatedButton(
                                    onPressed: pickBirthDate,
                                    child: Text(
                                      'Select birth date',
                                      style: TextStyle(fontSize: 15),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        ////////////////////Weight
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            margin: EdgeInsets.all(10),
                            decoration: containerDecoration,
                            child: Column(
                              children: [
                                Text(
                                  "Weight",
                                  style: titleStyle,
                                ),
                                SizedBox(
                                  height: screenHeight / 30,
                                ),
                                TextField(
                                  style: TextStyle(fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  controller: weight,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Write your weight',
                                      hintStyle: TextStyle(fontSize: 15)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (weight.text.length > 0 && height != 0) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ResultPage(
                              age: age,
                              BMI:
                                  int.parse(weight.text) / pow(height / 100, 2),
                              male: gender);
                        }));
                      }
                    },
                    child: Text('Calculate',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)))),
          )
        ],
      )),
    );
  }
}
