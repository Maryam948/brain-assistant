import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/Auth/cubit/auth_cubit.dart';

import '../view/signin.dart';

class Verfiy extends StatefulWidget {
  static const String routeName = '/verfiy';
  const Verfiy({super.key});

  @override
  State<Verfiy> createState() => _VerfiyState();
}

class _VerfiyState extends State<Verfiy> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("Assets/message.gif"), width: 300),
            
              const SizedBox(height: 20),
            
              Text(
                "Please check your email and verify your account",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: const Color(0xff757575),
                ),
              ),
            
              const SizedBox(height: 40),
            
              // ================= CHECK VERIFY =================
              TextButton(
                onPressed: () async {
                  final cubit = context.read<AuthCubit>();
            
                  bool ok = await cubit.isVerified();
            
                  if (ok) {
                    await cubit.saveUserToFirestore(); // 🔥 هنا فقط
            
                    Navigator.pushReplacementNamed(context, Signin.routeName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please verify your email first"),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(362, 60),
                ),
                child: const Text("Continue"),
              ),
            
              const SizedBox(height: 20),
            
              // ================= RESEND =================
            ],
          ),
        ),
      ),
    );
  }
}
