import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import 'package:untitled3/featuers/Auth/cubit/auth_cubit.dart';
import 'package:untitled3/featuers/Auth/cubit/auth_state.dart';
import 'package:untitled3/featuers/Auth/view/signup.dart';
import 'package:untitled3/pages/home.dart';
import 'package:untitled3/featuers/Auth/view/forget.dart';

import '../../../widgets/email_text_field.dart';
import '../../../widgets/password_text_field.dart';

class Signin extends StatefulWidget {
  static const String routeName = '/signin';
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> emailformcontroler = GlobalKey<FormState>();
  GlobalKey<FormState> passwordformcontroler = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        // 🔵 LOADING
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 🟢 SUCCESS
        if (state is LoginSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, Home.routeName);
        }

        // 🔴 ERROR
        if (state is LoginError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        
                  // ================= IMAGE =================
                  const Center(
                    child: Image(
                      image: AssetImage("Assets/splashbrain.png"),
                      width: 157,
                      height: 236,
                    ),
                  ),
        
                  const SizedBox(height: 6),
        
                  // ================= TOP BUTTONS (UNCHANGED UI) =================
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff1B4C46)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Signup.routeName);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xff247CFF),
                              minimumSize: const Size.fromHeight(60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Sign up",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff247CFF),
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 48),
        
                  Text(
                    "Welcome back  👋🏻​",
                    style: GoogleFonts.poppins(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        
                  const SizedBox(height: 8),
        
                  Text(
                    "Sign in to track your brain health",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xff757575),
                    ),
                  ),
        
                  const SizedBox(height: 30),
        
                  // ================= UI BUTTONS (UNCHANGED) =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton("Stroke"),
                      _buildButton("Alzheimer's"),
                    ],
                  ),
        
                  const SizedBox(height: 15),
        
                  _buildButton("Brain Tumor"),
        
                  const SizedBox(height: 20),
        
                  // ================= FIELDS =================
                  EmailTextField(
                    controller: _emailController,
                    formkey: emailformcontroler,
                  ),
        
                  const Gap(16),
        
                  PasswordTextField(
                    controller: _passwordController,
                    formkey: passwordformcontroler,
                  ),
        
                  const Gap(45),
        
                  // ================= FORGOT PASSWORD (UNCHANGED) =================
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Forget.routeName);
                      },
                      child: Text(
                        "Forgot Password",
                        style: GoogleFonts.poppins(
                          color: const Color(0xff247CFF),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 26),
        
                  // ================= SIGN IN BUTTON (FIX ONLY) =================
                  Center(
                    child: TextButton(
                      onPressed: () {
        
                        if (emailformcontroler.currentState!.validate() &&
                            passwordformcontroler.currentState!.validate()) {
        
                          context.read<AuthCubit>().login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff247CFF),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(362, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
        
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= UI HELPER (UNCHANGED) =================
  Widget _buildButton(String text) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        fixedSize: const Size(160, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blueAccent),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width: 9),
          Text(text),
        ],
      ),
    );
  }
}