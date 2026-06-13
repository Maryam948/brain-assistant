import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
    required this.controller,
    required this.formkey,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formkey;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {

  // 👇 نراقب الفوكس
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // 👇 نعيد بناء الواجهة عند الفوكس
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 👇 تنظيف مهم
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: widget.formkey,
        child: TextFormField(

          // 👇 ربط الفوكس
          focusNode: _focusNode,

          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,

          decoration: InputDecoration(

            // 👇 التغيير الأساسي
            labelText: _focusNode.hasFocus ? "Email" : "Email |",

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
              Icons.email_outlined,
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
                color: Color(0xffEDEDED),
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

          // 👇 validation
          validator: (entry) {
            if (entry!.isEmpty) {
              return "Email is required";
            } else if (!entry.contains('@gmail.com')) {
              return "Invalid email";
            }
            return null;
          },
        ),
      ),
    );
  }
}
