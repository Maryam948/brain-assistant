import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/pages/alzahimar_predict.dart';

class SafeResultAlzhimar extends StatefulWidget {
  static const String routeName = '/saferesultalzahimar';

  const SafeResultAlzhimar({super.key});

  @override
  State<SafeResultAlzhimar> createState() => _SafeResultAlzhimarState();
}

class _SafeResultAlzhimarState extends State<SafeResultAlzhimar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset("Assets/Group 18 (1).png", fit: BoxFit.cover),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xff36B936),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                        ],
                      ),
                      child: Center(child: Image.asset('Assets/whitetrue.png', width: 100, height: 118)
                      )
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'You\'re safe!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff36B936),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'No Alzheimer signs detected.  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff555555),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Stay healthy.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff555555),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'Assets/Vector (6).png',
                        width: 25,
                        height: 21.88,
                      ),
                    ],
                  ),

                  const SizedBox(height: 120),

                  SizedBox(
                    width: 362,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: const Color(0xff1976D2),
                      ),
                      onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AlzahimarPredict();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Check Again',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Image.asset("Assets/Group 17.png", fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
