import 'dart:core';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(''),
            ),
          ),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    List<String> buttons = [
      "AC",
      "+/-",
      "%",
      "÷",
      "7",
      "8",
      "9",
      "×",
      "4",
      "5",
      "6",
      "-",
      "1",
      "2",
      "3",
      "+",
      "0",
      ".",
      "=",
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        return _buildButton(buttons[index]);
      },
    );
  }

  Widget _buildButton(String value) {
    bool isOperator = ["÷", "×", "-", "+", "="].contains(value);
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isOperator ? Colors.orange : Colors.grey[850],
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(value, style: TextStyle(fontSize: 28, color: Colors.white)),
      ),
    );
  }
}
