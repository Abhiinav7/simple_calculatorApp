import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import '../shared_pref/db.dart';


class SimpleCalculator extends StatefulWidget {
  SimpleCalculator({ Key? key})
      : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  Map<String, bool> buttonElevationState = {
    "AC": false,
    "⌫": false,
    "%": false,
    "÷": false,
    "7": false,
    "8": false,
    "9": false,
    "x": false,
    "4": false,
    "5": false,
    "6": false,
    "−": false,
    "1": false,
    "2": false,
    "3": false,
    "+": false,
    "0": false,
    ".": false,
    "=": false,
    "history": false
  };

  var input = " ";
  var output = " ";
  var outputSize = 38.0;
  var inputSize = 50.0;

  ContactHistory contactHistory = ContactHistory();

  showHistory() async {
    //this  function help to get data stored in sharedpreference
    List data = await contactHistory.getContacts();
    String inputdata = data[0];
    String outputdata = data[1];
    if (inputdata.isNotEmpty || outputdata.isNotEmpty) {
      input = inputdata;
      output = outputdata;
      setState(() {});
    }
  }

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

        contactHistory.saveContacts(
            input, output); //function to add values to shared preference
      }
    } else if (value == "history") {
      return showHistory();
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        input,
                        style: GoogleFonts.aleo(
                            fontSize: inputSize, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: false,
                      child: Text(
                        output,
                        style: GoogleFonts.aleo(
                            fontSize: outputSize, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
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
              height: 20,
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
                // Container(width: 154, child: Button1(text: "0")),
                Button1(text: "0"),
                Button1(
                    icon: Icons.settings_backup_restore_sharp, text: "history"),
                Button1(text: "."),
                Button1(text: "=", tcolor: Colors.orange),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Button1({text, tcolor, IconData? icon}) {
    bool isElevated = buttonElevationState[text] ??
        false; // Use ?? to provide a default value
    Offset offset = isElevated ? Offset(2, 2) : Offset(3, 3);
    double blur = isElevated ? 5 : 5;

    return Listener(
      onPointerDown: (event) {
        onClick(text);
        setState(() {
          buttonElevationState[text] = true;
        });
      },
      onPointerUp: (event) {
        setState(() {
          buttonElevationState[text] = false;
        });
      },
      child: AnimatedContainer(
        child: Center(
          child: icon != null
              ? Icon(
            icon,
            size: 30,
            color: isElevated ? Colors.green : Colors.blueGrey,
          )
              : Text(
            text.toString(),
            style: GoogleFonts.abyssinicaSil(
              fontSize: 26,
              color: isElevated ? Colors.green : tcolor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        duration: const Duration(milliseconds: 40),
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFBEBEBE),
              offset: offset,
              blurRadius: blur,
              spreadRadius: 1,
              inset: isElevated,
            ),
            BoxShadow(
              color: Colors.white,
              offset: -offset,
              blurRadius: blur,
              spreadRadius: 1,
              inset: isElevated,
            ),
          ],
        ),
      ),
    );
  }
}
