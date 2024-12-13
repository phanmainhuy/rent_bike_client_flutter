import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final Function onSubmit;
  final String hint;
  final VoidCallback onTap;
  final bool readOnly;

  const SearchField({
    Key? key,
    required this.controller,
    required this.onSubmit,
    required this.hint,
    // required this.onChange,
    //required this.onTap,
    // required this.onTap,
    required this.onTap,
    required this.readOnly,
    this.onChange,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      controller: controller,
      keyboardType: TextInputType.text,
      onSubmitted: onSubmit(),
      //onTap: onTap(),
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 16),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 32.0),
            borderRadius: BorderRadius.circular(25.0)),
        // focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.white, width: 32.0),
        //     borderRadius: BorderRadius.circular(25.0)),
        contentPadding: const EdgeInsets.all (5),
        fillColor: Colors.white,
      ),
    );
  }
}