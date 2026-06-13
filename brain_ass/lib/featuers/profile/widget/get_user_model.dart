import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/Auth/data/user_model.dart';
import 'package:untitled3/widgets/screenunits.dart';

class GetUserModel extends StatelessWidget {
  const GetUserModel({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          userModel.name,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff07294C),
          ),
        ),

        SizedBox(height: ScreenSize.height / 50),
        Text(
          userModel.email,
          style: GoogleFonts.poppins(fontSize: 16, color: Color(0xff6E7C8F)),
        ),
      ],
    );
  }
}
