import 'dart:core';
import 'package:flutter/material.dart';
import 'package:simple_calculator/logic.dart';

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
  final CalculatorLogic calculator = CalculatorLogic();

  void _handlePress(String value) {
    setState(() {
      calculator.onPressed(value);
    });
  }

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
              child: Text(
                calculator.output.isEmpty
                    ? calculator.input
                    : calculator.output,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
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
    ];

    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 1.2,
          children: buttons.map((value) => _buildButton(value)).toList(),
        ),
        Row(
          children: [
            Expanded(flex: 2, child: _buildButton("0")),
            Expanded(flex: 1, child: _buildButton(".")),
            Expanded(flex: 1, child: _buildButton("=")),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String value) {
    bool isOperator = ["÷", "×", "-", "+", "="].contains(value);
    bool isZero = value == "0";

    return GestureDetector(
      onTap: () => _handlePress(value),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isOperator ? Colors.orange : Colors.grey[850],
          shape: isZero ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: isZero ? BorderRadius.circular(50) : null,
        ),
        alignment: isZero ? Alignment.centerLeft : Alignment.center,
        padding: isZero ? EdgeInsets.only(left: 30) : EdgeInsets.zero,
        height: 70,
        child: Text(value, style: TextStyle(fontSize: 28, color: Colors.white)),
      ),
    );
  }
}
