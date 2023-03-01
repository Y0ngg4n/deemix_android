import 'package:deemix_android/navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Deemix());
}

class Deemix extends StatelessWidget {
  const Deemix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deemix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigation(),
    );
  }
}
