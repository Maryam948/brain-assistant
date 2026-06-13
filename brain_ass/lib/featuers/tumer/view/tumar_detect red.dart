import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TumatDetectRed extends StatefulWidget {
  static const String routeName = '/tumatdetectred';

  const TumatDetectRed({super.key});

  @override
  State<TumatDetectRed> createState() => _TumatDetectRedState();
}

class _TumatDetectRedState extends State<TumatDetectRed> {
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
                  padding: const EdgeInsets.only(top:13 ,bottom:121 ,right:25 ,left:25),
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
                          'Result: Tumor Detected',
                          style: GoogleFonts.inter(
                            fontSize: 31,
                            color: Color(0xffB71C1C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 18),

                        Text(
                          'Signs of a brain tumor detected.',
                          style: GoogleFonts.poppins(
                            fontSize: 21,
                            color: Color(0xff757575),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 56,),
                        Container(
                          width: 362,
                     //     height: 125,
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
                                    'Assets/worning.png',
                                    width: 28,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text("Warning Scan",
                                    style: GoogleFonts.inter(
                                      fontSize: 26,
                                      color: Color(0xff242424),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2,),
                              Text(" The scan shows indications of a\n possible brain tumor.\nFurther medical evaluation is\n strongly recommended.",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: Color(0xff757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 36,),

                        Container(
                          width: 362,
                         // height: 177,
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
