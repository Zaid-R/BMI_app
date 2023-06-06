import 'package:flutter/material.dart';
import 'pages/infoPage.dart';

void main() => runApp(MaterialApp(
    home: InfoPage(),
    debugShowCheckedModeBanner: false,
    title: 'BMI App',
    theme: ThemeData(
        primarySwatch: Colors.teal,
        canvasColor: Colors.black,
        textTheme: const TextTheme(
          headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.black),
        ))));
