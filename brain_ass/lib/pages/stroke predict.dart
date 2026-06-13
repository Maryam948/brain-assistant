import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/pages/stroke predict2.dart';

import '../Models/inputs_models.dart';
import '../Models/shareddata.dart';
import '../widgets/input_data_text_field.dart';
import '../widgets/input_drop_dowen_button.dart';

class Strokepredict extends StatefulWidget {
  static const String routeName = '/stroke_predict';

  const Strokepredict({super.key});

  @override
  State<Strokepredict> createState() => _StrokepredictState();
}

class _StrokepredictState extends State<Strokepredict> {
  final TextEditingController ageController = TextEditingController();

  GlobalKey<FormState> ageformcontroler = GlobalKey<FormState>();

  String? selectedGender;
  String? selectedjob;
  String? selectedmarried;
  String? selectedResidence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 133, bottom: 81, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= TITLE =================
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Enter Your Health Data',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    color: const Color(0xff242424),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ================= CARD =================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF9F9FB),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xffEDEDED)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Personal Information',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ================= AGE ONLY =================
                      InputDataTextField(
                        controller: ageController,
                        formkey: ageformcontroler,
                        txt: "Age",
                      ),

                      const SizedBox(height: 30),

                      // ================= GENDER =================
                      InputDropDownButton(
                        items: genders,
                        selectedValue: selectedGender,
                        displayText: "",
                        txt: "Gender",
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        },
                      ),

                      const SizedBox(height: 30),

                      // ================= JOB =================
                      InputDropDownButton(
                        items: jobType,
                        selectedValue: selectedjob,
                        displayText: "",
                        txt: "Job Type",
                        onChanged: (value) {
                          setState(() {
                            selectedjob = value.toString();
                          });
                        },
                      ),

                      const SizedBox(height: 30),

                      // ================= MARRIED =================
                      InputDropDownButton(
                        items: married,
                        selectedValue: selectedmarried,
                        displayText: "",
                        txt: "Ever Married",
                        onChanged: (value) {
                          setState(() {
                            selectedmarried = value.toString();
                          });
                        },
                      ),

                      const SizedBox(height: 30),

                      // ================= RESIDENCE =================
                      InputDropDownButton(
                        items: residenceType,
                        selectedValue: selectedResidence,
                        displayText: "",
                        txt: "Residence Type",
                        onChanged: (value) {
                          setState(() {
                            selectedResidence = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 100),

              // ================= CONTINUE BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: const Color(0xff1976D2),
                  ),
                  onPressed: () {
                    // ===== OLD LOGIC (NO NAME) =====
                    SharedData.age =
                        int.tryParse(ageController.text) ?? 20;
                    SharedData.gender = selectedGender;
                    SharedData.everMarried = selectedmarried;
                    SharedData.workType = selectedjob;
                    SharedData.residenceType = selectedResidence;

                    Navigator.pushReplacementNamed(
                      context,
                      Strokepredict2.routeName,
                    );
                  },
                  child: Text(
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}