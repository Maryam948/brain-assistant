// alzahimar_predict3.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/alzahiemer/cubit/alzahimer_cubit.dart';
import 'package:untitled3/pages/alzahimar_predict4.dart';
import 'package:untitled3/widgets/input_data_text_field.dart';
import 'package:untitled3/widgets/input_drop_dowen_button.dart';

class AlzahimarPredict3 extends StatefulWidget {
  static const String routeName = '/alzahimar_predict3';
  const AlzahimarPredict3({super.key});
  @override
  State<AlzahimarPredict3> createState() => _AlzahimarPredict3State();
}

class _AlzahimarPredict3State extends State<AlzahimarPredict3> {
  String? selectedFamilyHistory;
  String? selectedCardiovascular;
  String? selectedDiabetes;
  String? selectedDepression;
  String? selectedHeadInjury;
  String? selectedHypertension;
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController mmseController = TextEditingController();
  final GlobalKey<FormState> systolicKey = GlobalKey<FormState>();
  final GlobalKey<FormState> diastolicKey = GlobalKey<FormState>();
  final GlobalKey<FormState> cholesterolKey = GlobalKey<FormState>();
  final GlobalKey<FormState> mmseKey = GlobalKey<FormState>();
  double functionalAssessment = 5;
  double adl = 5;
  final List<String> yesNo = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 133, bottom: 81, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Your Health Data', style: GoogleFonts.inter(fontSize: 32, color: const Color(0xff242424), fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('Step 3 of 4 — Medical History', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
              _card('Medical History', [
                InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedFamilyHistory = v), selectedValue: selectedFamilyHistory, displayText: '', txt: "Family History of Alzheimer's"),
                const SizedBox(height: 20),
                InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedCardiovascular = v), selectedValue: selectedCardiovascular, displayText: '', txt: "Cardiovascular Disease"),
                const SizedBox(height: 20),
                InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedDiabetes = v), selectedValue: selectedDiabetes, displayText: '', txt: "Diabetes"),
                const SizedBox(height: 20),
                InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedDepression = v), selectedValue: selectedDepression, displayText: '', txt: "Depression"),
                const SizedBox(height: 20),
                InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedHeadInjury = v), selectedValue: selectedHeadInjury, displayText: '', txt: "Head Injury"),
                const SizedBox(height: 20),
                InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedHypertension = v), selectedValue: selectedHypertension, displayText: '', txt: "Hypertension"),
              ]),
              const SizedBox(height: 20),
              _card('Clinical Measurements', [
                InputDataTextField(controller: systolicController, formkey: systolicKey, txt: "Systolic BP (90–180 mmHg)"),
                const SizedBox(height: 20),
                InputDataTextField(controller: diastolicController, formkey: diastolicKey, txt: "Diastolic BP (60–120 mmHg)"),
                const SizedBox(height: 20),
                InputDataTextField(controller: cholesterolController, formkey: cholesterolKey, txt: "Cholesterol HDL (20–100 mg/dL)"),
                const SizedBox(height: 20),
                InputDataTextField(controller: mmseController, formkey: mmseKey, txt: "MMSE Score (0–30)"),
                const SizedBox(height: 20),
                _slider("Functional Assessment", functionalAssessment, 0, 10, 10, "/10", (v) => setState(() => functionalAssessment = v)),
                const SizedBox(height: 10),
                _slider("ADL (Activities of Daily Living)", adl, 0, 10, 10, "/10", (v) => setState(() => adl = v)),
              ]),
              const SizedBox(height: 40),
              _continueBtn(() {
                final cubit = context.read<AlzahimarCubit>();
                cubit.familyHistory = selectedFamilyHistory ?? "No";
                cubit.cardiovascularDisease = selectedCardiovascular ?? "No";
                cubit.diabetes = selectedDiabetes ?? "No";
                cubit.depression = selectedDepression ?? "No";
                cubit.headInjury = selectedHeadInjury ?? "No";
                cubit.hypertension = selectedHypertension ?? "No";
                cubit.systolicBP = double.tryParse(systolicController.text) ?? 120;
                cubit.diastolicBP = double.tryParse(diastolicController.text) ?? 80;
                cubit.cholesterolHDL = double.tryParse(cholesterolController.text) ?? 50;
                cubit.mmse = double.tryParse(mmseController.text) ?? 15;
                cubit.functionalAssessment = functionalAssessment;
                cubit.adl = adl;
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const AlzahimarPredict4(),
                  ),
                ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(String title, List<Widget> children) => Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xffF9F9FB), borderRadius: BorderRadius.circular(25), border: Border.all(color: const Color(0xffEDEDED)), boxShadow: const [BoxShadow(color: Color(0xffFFFFFF), blurRadius: 5, offset: Offset(0, 3))]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Text(title, style: GoogleFonts.inter(fontSize: 24, color: const Color(0xff242424), fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            ...children,
          ]),
        ),
      );

  Widget _continueBtn(VoidCallback onPressed) => SizedBox(
        width: double.infinity, height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: const Color(0xff1976D2)),
          onPressed: onPressed,
          child: Text('Continue', style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
        ),
      );

  Widget _slider(String label, double value, double min, double max, int divisions, String unit, ValueChanged<double> onChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff242424))),
        Text('${value.toStringAsFixed(1)}$unit', style: GoogleFonts.inter(fontSize: 15, color: const Color(0xff1976D2), fontWeight: FontWeight.w600)),
      ]),
      Slider(value: value, min: min, max: max, divisions: divisions, activeColor: const Color(0xff1976D2), inactiveColor: const Color(0xffEDEDED), onChanged: onChanged),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('${min.toInt()}', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
        Text('${max.toInt()}', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
      ]),
    ]);
  }
}