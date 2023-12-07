import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  bool _isElevated = false;
  var input = " ";
  var output = " ";

  // bool hideInput=false;
  var outputSize = 38.0;
  var inputSize = 50.0;



  onClick(value) {
    if (value == "AC") {
      input = " ";
      output = " ";
    } else if (value == "⌫") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = userInput.replaceAll("x", "*");
        userInput = userInput.replaceAll("−", "-");
        userInput = userInput.replaceAll("%", "%");
        userInput = userInput.replaceAll("÷", "/");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        //input=output;
        // hideInput=true;
        // outputSize=50;
      }
    } else {
      input = input + value;
      // hideInput=false;
      // outputSize=38.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(
                        fontSize: inputSize, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    //hideInput ? " " : output,
                    output,
                    style: TextStyle(
                        fontSize: outputSize, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button1(text: "AC", tcolor: Colors.orange),
                Button1(text: "⌫", tcolor: Colors.orange),
                Button1(text: "%", tcolor: Colors.orange),
                Button1(text: "÷", tcolor: Colors.orange),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button1(text: "7"),
                Button1(text: "8"),
                Button1(text: "9"),
                Button1(text: "x", tcolor: Colors.orange),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button1(text: "4"),
                Button1(text: "5"),
                Button1(text: '6'),
                Button1(text: "−", tcolor: Colors.orange),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button1(text: "1"),
                Button1(text: "2"),
                Button1(text: "3"),
                Button1(text: "+", tcolor: Colors.orange),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 148, child: Button1(text: "0")),
                Button1(text: "."),
                Button1(text: "=", tcolor: Colors.orange),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Button1({text, tcolor}) {
    Offset offset = _isElevated ? Offset(2, 2) : Offset(3, 3);
    double blur = _isElevated ? 5 : 5;
    return Listener(
      onPointerDown: (event) {
        onClick(text);
        setState(() {
          _isElevated = true;
        });
      },
      onPointerUp: (event) {
        setState(() {
          _isElevated = false;
        });
      },
      child: AnimatedContainer(
        child: Center(
            child: Text(
          text.toString(),
          style: GoogleFonts.abyssinicaSil(
              fontSize: 26,
              color: _isElevated ? Colors.green : tcolor,
              fontWeight: FontWeight.w600),
        )),
        duration: const Duration(
          milliseconds: 40,
        ),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFBEBEBE),
                offset: offset,
                blurRadius: blur,
                spreadRadius: 1,
                inset: _isElevated,
              ),
              BoxShadow(
                color: Colors.white,
                offset: -offset,
                blurRadius: blur,
                spreadRadius: 1,
                inset: _isElevated,
              ),
            ]),
      ),
    );
  }
}
