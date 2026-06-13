import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.formkey,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formkey;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  // 👇 بيتحكم في إظهار/إخفاء الباسورد
  bool _obscurePassword = true;

  // 👇 بنستخدمه عشان نعرف هل المستخدم واقف في الـ TextField ولا لأ
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // 👇 بنسمع أي تغيير في الفوكس (دخول/خروج من الـ field)
    _focusNode.addListener(() {
      setState(() {}); // 👈 بنعمل rebuild عشان نغير الـ label حسب الحالة
    });
  }

  @override
  void dispose() {
    // 👇 مهم جدًا: تنظيف الـ FocusNode عشان ميسببش memory leak
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: widget.formkey,
        child: TextFormField(

          // 👇 ربطنا الـ FocusNode بالـ TextField
          focusNode: _focusNode,

          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: _obscurePassword,
          textAlignVertical: TextAlignVertical.center,

          decoration: InputDecoration(

            // 👇 التغيير الأساسي هنا
            // قبل: ثابت "Password |"
            // بعد: بيتغير حسب الفوكس
            labelText: _focusNode.hasFocus ? "Password" : "Password |",

            // 👇 شكل اللابل لما يكون طالع فوق
            floatingLabelStyle: GoogleFonts.inter(
              color: const Color(0xff757575),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),

            // 👇 شكل اللابل وهو داخل الـ field (قبل الضغط)
            labelStyle: GoogleFonts.inter(
              color: const Color(0xffE0E0E0),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),

            // 👇 زر إظهار/إخفاء الباسورد
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Color(0xff757575),
              ),
              onPressed: () {
                setState(() {
                  // 👇 بنقلب حالة إظهار الباسورد
                  _obscurePassword = !_obscurePassword;
                });
              },
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

          // 👇 validation للباسورد
          validator: (entry) {
            if (entry!.isEmpty) {
              return "Password is required";
            } else if (entry.length < 6) {
              return "Password must be at least 6 characters";
            }
            return null;
          },
        ),
      ),
    );
  }
}
