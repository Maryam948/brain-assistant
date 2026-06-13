// alzahimar_predict2.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/alzahiemer/cubit/alzahimer_cubit.dart';
import 'package:untitled3/pages/alzahimar_predict3.dart';
import 'package:untitled3/widgets/input_data_text_field.dart';
import 'package:untitled3/widgets/input_drop_dowen_button.dart';

class AlzahimarPredict2 extends StatefulWidget {
  static const String routeName = '/alzahimar_predict2';
  const AlzahimarPredict2({super.key});
  @override
  State<AlzahimarPredict2> createState() => _AlzahimarPredict2State();
}

class _AlzahimarPredict2State extends State<AlzahimarPredict2> {
  final TextEditingController bmiController = TextEditingController();
  final GlobalKey<FormState> bmiFormKey = GlobalKey<FormState>();
  String? selectedSmoking;
  double alcoholConsumption = 0;
  double physicalActivity = 0;
  double sleepQuality = 4;
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
              Text('Step 2 of 4 — Lifestyle', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
              _card('Lifestyle', [
                InputDataTextField(controller: bmiController, formkey: bmiFormKey, txt: "BMI"),
                const SizedBox(height: 25),
                InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedSmoking = v), selectedValue: selectedSmoking, displayText: '', txt: "Smoking"),
                const SizedBox(height: 25),
                _slider("Alcohol Consumption", alcoholConsumption, 0, 20, 20, " units/week", (v) => setState(() => alcoholConsumption = v)),
                const SizedBox(height: 15),
                _slider("Physical Activity", physicalActivity, 0, 10, 10, " hrs/week", (v) => setState(() => physicalActivity = v)),
                const SizedBox(height: 15),
                _slider("Sleep Quality", sleepQuality, 4, 10, 6, "/10", (v) => setState(() => sleepQuality = v)),
              ]),
              const SizedBox(height: 40),
              _continueBtn(() {
                final cubit = context.read<AlzahimarCubit>();
                cubit.bmi = double.tryParse(bmiController.text) ?? 0;
                cubit.smokingStatus = selectedSmoking ?? "No";
                cubit.alcoholConsumption = alcoholConsumption;
                cubit.physicalActivity = physicalActivity;
                cubit.sleepQuality = sleepQuality;
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const AlzahimarPredict3(),
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
            const SizedBox(height: 25),
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