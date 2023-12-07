import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

class MyButton extends StatefulWidget {
  const MyButton({super.key});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isElevated = false;

  @override
  Widget build(BuildContext context) {
    Offset offset = _isElevated ? Offset(2, 2) : Offset(3, 3);
    double blur = _isElevated ? 5 : 5;
    return Listener(
            onPointerDown: (event) {
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
        child: Icon(
          Icons.power_settings_new,
          size: 40,
          color: _isElevated ? Colors.green : Colors.grey,
        ),
        duration: const Duration(
          milliseconds: 40,
        ),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
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
