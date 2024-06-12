import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnText;
  final Function() onBtnPressed;

  const RoundedButton(
      {super.key, required this.btnText, required this.onBtnPressed});
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5,
       // color: Color.fromARGB(193, 224, 174, 221),
       color: Color.fromARGB(193, 114, 195, 245),

      // color: Color.fromARGB(193, 106, 194, 249),
      
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onBtnPressed,
          minWidth: 270,
          height: 30,
          child: Text(
            btnText,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }
}
