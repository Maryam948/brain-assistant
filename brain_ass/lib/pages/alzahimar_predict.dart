// alzahimar_predict1.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/alzahiemer/cubit/alzahimer_cubit.dart';
import 'package:untitled3/pages/alzahimar_predict2.dart';
import 'package:untitled3/widgets/input_data_text_field.dart';
import 'package:untitled3/widgets/input_drop_dowen_button.dart';

class AlzahimarPredict extends StatefulWidget {
  static const String routeName = '/alzahimar_predict';
  const AlzahimarPredict({super.key});
  @override
  State<AlzahimarPredict> createState() => _AlzahimarPredictState();
}

class _AlzahimarPredictState extends State<AlzahimarPredict> {
  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> ageFormKey = GlobalKey<FormState>();
  String? selectedGender;
  String? selectedEducation;
  final List<String> genders = ["Male", "Female"];
  final List<String> educationLevels = ["None", "Low", "Medium", "High"];

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
              Text('Step 1 of 4 — Personal Information', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
              _card('Personal Information', [
                InputDataTextField(controller: ageController, formkey: ageFormKey, txt: "Age"),
                const SizedBox(height: 25),
                InputDropDownButton(items: genders, onChanged: (v) => setState(() => selectedGender = v), selectedValue: selectedGender, displayText: '', txt: "Gender"),
                const SizedBox(height: 25),
                InputDropDownButton(items: educationLevels, onChanged: (v) => setState(() => selectedEducation = v), selectedValue: selectedEducation, displayText: '', txt: "Education Level"),
              ]),
              const SizedBox(height: 40),
              _continueBtn(() {
                final cubit = context.read<AlzahimarCubit>();
                cubit.age = int.tryParse(ageController.text) ?? 0;
                cubit.gender = selectedGender ?? "Male";
                cubit.education = selectedEducation ?? "None";
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const AlzahimarPredict2(),
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
}