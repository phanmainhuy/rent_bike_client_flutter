import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;

  const MyButton({required this.name, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 400,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff0d0071))),
        // padding: Padding(padding: EdgeInsets(),),
        // padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        // color: const Color(0xff0d0071),
        onPressed: onPressed,
      ),
    );
  }
}
