import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameTextField extends StatefulWidget {
  const NameTextField({
    super.key,
    required this.controller,
    required this.formkey,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formkey;

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {

  // 👇 بنراقب الفوكس
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // 👇 أي تغيير في الفوكس يعمل rebuild
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 👇 تنظيف مهم جدًا
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: widget.formkey,
        child: TextFormField(

          // 👇 ربط الفوكس بالـ TextField
          focusNode: _focusNode,

          controller: widget.controller,
          textAlignVertical: TextAlignVertical.center,

          decoration: InputDecoration(

            // 👇 التغيير هنا (زي password بالظبط)
            labelText: _focusNode.hasFocus ? "Name" : "Name |",

            floatingLabelStyle: GoogleFonts.inter(
              color: const Color(0xff757575),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),

            labelStyle: GoogleFonts.inter(
              color: const Color(0xffE0E0E0),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),

            suffixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xff757575),
            ),

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xffC2C2C2),
                width: 1.5,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xffC2C2C2),
                width: 1.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xffEDEDED),
                width: 2,
              ),
            ),
          ),

          validator: (entry) {
            if (entry!.isEmpty) {
              return "Your name is required";
            }
            return null;
          },
        ),
      ),
    );
  }
}
