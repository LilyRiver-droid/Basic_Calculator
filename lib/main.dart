import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calculatorBtn(
      String btnText, Color btnColor, Color txtColor, bool isDisabled) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.width / 5,
      child: ElevatedButton(
        onPressed: isDisabled
            ? null
            : () {
                calculation(btnText);
              },
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 15.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 32,
              color: txtColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculatorBtn('', Colors.black, Colors.black, true),
                calculatorBtn('', Colors.black, Colors.black, true),
                calculatorBtn('', Colors.black, Colors.black, true),
                calculatorBtn('AC', Colors.orangeAccent, Colors.black, false),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculatorBtn('7', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('8', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('9', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('/', Colors.grey, Colors.white, false),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculatorBtn('4', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('5', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('6', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('x', Colors.grey, Colors.white, false),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculatorBtn('1', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('2', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('3', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('-', Colors.grey, Colors.white, false),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculatorBtn('0', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('.', Colors.grey.shade800, Colors.white, false),
                calculatorBtn('=', Colors.blueAccent.shade700, Colors.white, false),
                calculatorBtn('+', Colors.grey, Colors.white, false),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC' || btnText == '') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = addition();
      } else if (preOpr == '-') {
        finalResult = subtraction();
      } else if (preOpr == 'x') {
        finalResult = multiplication();
      } else if (preOpr == '/') {
        finalResult = division();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = addition();
      } else if (opr == '-') {
        finalResult = subtraction();
      } else if (opr == 'x') {
        finalResult = multiplication();
      } else if (opr == '/') {
        finalResult = division();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String addition() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return isDecimal(result);
  }

  String subtraction() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return isDecimal(result);
  }

  String multiplication() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return isDecimal(result);
  }

  String division() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return isDecimal(result);
  }

  String isDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
