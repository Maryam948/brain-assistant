import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarding.dart';

class Splash extends StatefulWidget {
  static const String routeName = '/splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      Onboarding.routeName,
    );

    // if (FirebaseAuth.instance.currentUser != null) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const Home()),
    //   );
    // } else {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const Onboarding()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Stack(
          children:[
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "Assets/splashbrain.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Image(
                  image: AssetImage("Assets/splashbrain.png"),
                  fit: BoxFit.cover,
            
            
                 width: 107,
                  height: 160,
                ),
                Text("Brain Health \nAssistant" ,
                  style: GoogleFonts.poppins(
                    color: Color(0xff242424),
                    fontSize: 39,
                    fontWeight: FontWeight.w600,
            
                  ),
                )
              ],
            ),
          ),
            
          ]
        ),
      ),
    );
  }
}
