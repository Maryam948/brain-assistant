import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/Auth/view/signin.dart';

class Onboarding extends StatefulWidget {
  static const String routeName = '/onboarding';
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              const Image(
                image: AssetImage("Assets/robotonboarding.png"),
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            
              const SizedBox(height: 20),
            
              Text(
                "Track Your Brain \nHealth",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xff242424),
                  fontSize: 39,
                  fontWeight: FontWeight.w600,
                ),
              ),
            
              const SizedBox(height: 40),
            
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Signin.routeName);
            
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(362, 60),
                  padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
