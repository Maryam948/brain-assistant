import 'package:flutter/material.dart';

class InputDataTextField extends StatelessWidget {
  const InputDataTextField({
    super.key,
    required this.controller,
    required this.formkey,
    required this.txt,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formkey;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: Form(
        key: formkey,
        child: TextFormField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: txt,
            hintStyle: const TextStyle(color: Color(0xff757575)),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),
            ),
            filled: true,
            fillColor: const Color(0xffFFFFFF),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          ),
          validator: (entry) {
            if (entry == null || entry.isEmpty) {
              return "This field is required";
            }
            return null;
          },
        ),
      ),
    );
  }
}
