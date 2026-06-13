import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/pages/saferesult.dart';
import 'package:untitled3/pages/wariningresult.dart';
import 'package:untitled3/serviece/prediction_serviece.dart';

import '../Models/converts.dart';
import '../Models/inputs_models.dart';
import '../Models/shareddata.dart';
import '../widgets/input_data_text_field.dart';
import '../widgets/input_drop_dowen_button.dart';

class Strokepredict2 extends StatefulWidget {
  static const String routeName = '/stroke_predict2';

  const Strokepredict2({super.key});

  @override
  State<Strokepredict2> createState() => _Strokepredict2State();
}

class _Strokepredict2State extends State<Strokepredict2> {
  final TextEditingController glucoseController = TextEditingController();
  final GlobalKey<FormState> glucoseformcontroler = GlobalKey<FormState>();

  final TextEditingController bmiController = TextEditingController();
  final GlobalKey<FormState> bmiformcontroler = GlobalKey<FormState>();

  String? selectedhypertension;
  String? selectedsmoked;
  String? selectedheartdisease;
  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
          padding: const EdgeInsets.only(top:133 ,bottom:81 ,right:20 ,left:20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(
                width: double.infinity,

                child: Text(
                  'Enter Your Health Data',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    color: const Color(0xff242424),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                //     height: 550,
                decoration: BoxDecoration(
                  color: Color(0xffF9F9FB),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xffEDEDED),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffFFFFFF),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 30),
                      Text(
                        'Health Factors',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          color: const Color(0xff242424),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 56),
                      /*InputDataTextField(
                        controller: nameController,
                        formkey: nameformcontroler,
                        txt: 'Name',
                      ),*/
                      const SizedBox(height: 30),
                      InputDropDownButton(
                        selectedValue: selectedhypertension,
                        onChanged: (value) {
                          setState(() {
                            selectedhypertension = value.toString();
                          });
                        },
                        items: hypertension,
                        txt: "Hypertension", displayText: '',
                      ),                      const SizedBox(height: 30),
                      InputDropDownButton(
                        selectedValue: selectedheartdisease,
                        onChanged: (value) {
                          setState(() {
                            selectedheartdisease = value.toString();
                          });
                        },
                        items: heartDisease,
                        txt: "Heart disease", displayText: '',
                      ),
                    const SizedBox(height: 30),

                      InputDropDownButton(
                        selectedValue: selectedsmoked,
                        onChanged: (value) {
                          setState(() {
                            selectedsmoked = value.toString();
                          });
                        },
                        items: smoke,
                        txt: "Smoking", displayText: '',
                      ),
                      const SizedBox(height: 30),
                      InputDataTextField(
                        controller: glucoseController,
                        formkey: glucoseformcontroler,
                        txt: "Average glucose level",
                      ),

                      const SizedBox(height: 25),

                      InputDataTextField(
                        controller: bmiController,
                        formkey: bmiformcontroler,
                        txt: "bmi",
                      ),                      /*   InputDropDownButton(
                        selectedValue: selectedResidence,
                        onChanged: (value) {
                          setState(() {
                            selectedResidence = value.toString();
                          });
                        },
                        items: residenceType,
                        displayText: "",
                        txt: "Residence Type: ",
                      ),*/
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              SizedBox(
                width: 362,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1976D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    
                    SharedData.hypertension = selectedhypertension;
                    SharedData.heartDisease = selectedheartdisease;
                    SharedData.smokingStatus = selectedsmoked;
                    SharedData.glucose =
                        double.tryParse(glucoseController.text) ?? 0.0;
                    SharedData.bmi =
                        double.tryParse(bmiController.text) ?? 0.0;

                    List<double> featuresRaw = [
                      genderToDouble(SharedData.gender ?? "Male"),
                      (SharedData.age ?? 20).toDouble(),
                      yesNoToDouble(SharedData.hypertension ?? "No"),
                      yesNoToDouble(SharedData.heartDisease ?? "No"),
                      yesNoToDouble(SharedData.everMarried ?? "No"),
                      workTypeToDouble(SharedData.workType ?? "Private"),
                      residenceToDouble(
                          SharedData.residenceType ?? "Urban"),
                      SharedData.glucose ?? 0.0,
                      SharedData.bmi ?? 0.0,
                      smokingToDouble(
                          SharedData.smokingStatus ?? "never smoked"),
                    ];

                    print("RAW Features sent: $featuresRaw");

               final result =
                    await ApiService.sendFeatures(featuresRaw);

                 if (result != null) {
                      int prediction = result["prediction"];
                      double probability = result["probability"];

                      print("Prediction: $prediction");
                      print("Probability: $probability");

                      if (prediction == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Wariningresult()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Saferesult()),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Predict',
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
      ),
    );
  }
}
