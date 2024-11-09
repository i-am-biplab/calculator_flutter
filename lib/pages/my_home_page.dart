import 'package:calculator/components/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuery = "";
  var queryAnswer = "";

  var lastQueryHistory = "";

  final EdgeInsetsGeometry? textPadding =
      const EdgeInsets.only(left: 26, right: 26);

  List<String> buttons = [
    "AC",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "=",
    "C"
  ];

  bool isArithmeticOperator(String s) {
    if (s == "AC" ||
        s == "DEL" ||
        s == "%" ||
        s == "/" ||
        s == "x" ||
        s == "-" ||
        s == "+") {
      return true;
    }
    return false;
  }

  bool isEqualsOperator(String s) {
    if (s == "=") {
      return true;
    }
    return false;
  }

  bool isEvaluated = false;

  void equalsToPressed() {
    String finalUserQuery = userQuery;
    finalUserQuery = finalUserQuery.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserQuery);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    String evalStr = eval.toString();
    String evalDecimalPart = evalStr.split('.')[1];

    queryAnswer = "= ";

    if (int.parse(evalDecimalPart) != 0) {
      queryAnswer += eval.toString();
    } else {
      queryAnswer += eval.toInt().toString();
    }

    isEvaluated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: textPadding,
              alignment: Alignment.bottomRight,
              child: Text(
                lastQueryHistory,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: textPadding,
                  alignment: Alignment.bottomRight,
                  child: Text(
                    userQuery,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: textPadding,
                  alignment: Alignment.bottomRight,
                  child: Text(
                    queryAnswer,
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: GridView.builder(
                itemCount: buttons.length - 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // clear button
                  if (index == 0) {
                    if (userQuery != "") {
                      return CalcButton(
                        buttonColor: isEqualsOperator(buttons[index])
                            ? Colors.orange
                            : Colors.grey.shade800,
                        buttonText: buttons[20],
                        buttonTextColor: isArithmeticOperator(buttons[index])
                            ? Colors.orange
                            : Colors.white,
                        buttonTapped: () {
                          setState(() {
                            lastQueryHistory = isEvaluated
                                ? userQuery + queryAnswer
                                : lastQueryHistory;
                            isEvaluated = false;
                            userQuery = "";
                            queryAnswer = "";
                          });
                        },
                      );
                    } else {
                      return CalcButton(
                        buttonColor: isEqualsOperator(buttons[index])
                            ? Colors.orange
                            : Colors.grey.shade800,
                        buttonText: buttons[index],
                        buttonTextColor: isArithmeticOperator(buttons[index])
                            ? Colors.orange
                            : Colors.white,
                        buttonTapped: () {
                          setState(() {
                            lastQueryHistory = "";
                          });
                        },
                      );
                    }
                  }

                  // delete button
                  else if (index == 1) {
                    return CalcButton(
                      buttonColor: isEqualsOperator(buttons[index])
                          ? Colors.orange
                          : Colors.grey.shade800,
                      buttonText: buttons[index],
                      buttonTextColor: isArithmeticOperator(buttons[index])
                          ? Colors.orange
                          : Colors.white,
                      buttonTapped: () {
                        if (userQuery != "") {
                          setState(() {
                            userQuery =
                                userQuery.substring(0, userQuery.length - 1);
                          });
                          isEvaluated = false;
                        }
                      },
                    );
                  }

                  // equals button
                  else if (index == buttons.length - 2) {
                    return CalcButton(
                      buttonColor: isEqualsOperator(buttons[index])
                          ? Colors.orange
                          : Colors.grey.shade800,
                      buttonText: buttons[index],
                      buttonTextColor: isArithmeticOperator(buttons[index])
                          ? Colors.orange
                          : Colors.white,
                      buttonTapped: () {
                        setState(() {
                          equalsToPressed();
                        });
                      },
                    );
                  } else {
                    return CalcButton(
                      buttonColor: isEqualsOperator(buttons[index])
                          ? Colors.orange
                          : Colors.grey.shade800,
                      buttonText: buttons[index],
                      buttonTextColor: isArithmeticOperator(buttons[index])
                          ? Colors.orange
                          : Colors.white,
                      buttonTapped: () {
                        setState(() {
                          userQuery += buttons[index];
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
