import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TumatDetectGreen extends StatefulWidget {
  static const String routeName = '/tumatdetectgreen';

  const TumatDetectGreen({super.key});

  @override
  State<TumatDetectGreen> createState() => _TumatDetectGreenState();
}

class _TumatDetectGreenState extends State<TumatDetectGreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top:13 ,bottom:160 ,right:25 ,left:25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: const Image(
                            image: AssetImage("Assets/splashbrain.png"),
                            width: 195,
                            height: 293,
                          ),
                        ),
                        Text(
                          'Result: Healthy',
                          style: GoogleFonts.inter(
                            fontSize: 31,
                            color: Color(0xff008000),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 18),

                        Text(
                          'No signs of a brain tumor detected.',
                          style: GoogleFonts.poppins(
                            fontSize: 21,
                            color: Color(0xff757575),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 56,),
                        Container(
                          width: 362,
                        //  height: 125,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xffEEFFEE),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xff36B936), width: 1),

                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'Assets/true.png',
                                    width: 28,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                   Text(" Healthy Scan",
                                     style: GoogleFonts.inter(
                                     fontSize: 26,
                                     color: Color(0xff242424),
                                     fontWeight: FontWeight.w500,
                                   ),
                                   ),
                                ],
                              ),
                              SizedBox(height: 2,),
                              Text(" Your brain scan looks normal.\nNo abnormalities detected.",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: Color(0xff757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 47,),

                        Container(
                          width: 362,
                      //    height: 125,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xffF9F9FB),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xffC9C9C9), width: 1),

                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'Assets/explination.png',
                                    width: 28,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(" Disclaimer:",
                                    style: GoogleFonts.inter(
                                      fontSize: 26,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2,),
                              Text(" This result are generated by AI is not a\n substitute for a professional medical\n diagnosis.\nplease consult a doctor for confirmation.",
                                style: GoogleFonts.inter(
                                  fontSize: 17,
                                  color: Color(0xff757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )


                      ]
                  )

              )
          )
          ),
    );
  }
}
