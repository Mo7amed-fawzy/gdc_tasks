import 'package:flutter/foundation.dart';

class CalculatorLogic {
  String _input = "";
  String _output = "";

  String get input => _input;
  String get output => _output;

  void onPressed(String value) {
    if (value == "AC") {
      _input = "";
      _output = "";
    } else if (value == "=") {
      try {
        if (kDebugMode) {
          print("Evaluating: $_input");
        }
        double result = evaluateExpression(_input);
        _output = result.isNaN ? "Error" : result.toString();
      } catch (e) {
        if (kDebugMode) {
          print("Error evaluating: $e");
        }
        _output = "Error";
      }
    } else {
      _input += value;
    }
  }

  double evaluateExpression(String expression) {
    try {
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');

      RegExp regex = RegExp(r'(\d+(\.\d+)?)|[+\-*/]');
      List<String> tokens =
          regex.allMatches(expression).map((m) => m.group(0)!).toList();

      List<double> numbers = [];
      List<String> operators = [];

      for (var token in tokens) {
        if (RegExp(r'^\d+(\.\d+)?$').hasMatch(token)) {
          numbers.add(double.parse(token));
        } else if ("+-*/".contains(token)) {
          while (operators.isNotEmpty &&
              _hasHigherPrecedence(operators.last, token)) {
            _compute(numbers, operators);
          }
          operators.add(token);
        }
      }

      while (operators.isNotEmpty) {
        _compute(numbers, operators);
      }

      return numbers.isNotEmpty ? numbers.last : double.nan;
    } catch (e) {
      return double.nan;
    }
  }

  bool _hasHigherPrecedence(String op1, String op2) {
    Map<String, int> precedence = {'+': 1, '-': 1, '*': 2, '/': 2};
    return precedence[op1]! >= precedence[op2]!;
  }

  void _compute(List<double> numbers, List<String> operators) {
    if (numbers.length < 2 || operators.isEmpty) return;

    double b = numbers.removeLast();
    double a = numbers.removeLast();
    String op = operators.removeLast();

    switch (op) {
      case '+':
        numbers.add(a + b);
        break;
      case '-':
        numbers.add(a - b);
        break;
      case '*':
        numbers.add(a * b);
        break;
      case '/':
        numbers.add(b != 0 ? a / b : double.nan);
        break;
    }
  }
}
