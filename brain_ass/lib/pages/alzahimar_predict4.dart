// alzahimar_predict4.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/alzahiemer/cubit/alzahimer_cubit.dart';
import 'package:untitled3/featuers/alzahiemer/cubit/alzahimer_state.dart';
import 'package:untitled3/pages/saferesult%20alzahimar.dart';
import 'package:untitled3/pages/wariningresult_alzahimar.dart';
import 'package:untitled3/widgets/input_drop_dowen_button.dart';

class AlzahimarPredict4 extends StatefulWidget {
  static const String routeName = '/alzahimar_predict4';
  const AlzahimarPredict4({super.key});
  @override
  State<AlzahimarPredict4> createState() => _AlzahimarPredict4State();
}

class _AlzahimarPredict4State extends State<AlzahimarPredict4> {
  String? selectedMemoryComplaints;
  String? selectedBehavioralProblems;
  String? selectedConfusion;
  String? selectedDisorientation;
  String? selectedPersonalityChanges;
  String? selectedDifficultyTasks;
  String? selectedForgetfulness;
  final List<String> yesNo = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlzahimarCubit, AlzahimarState>(
      listener: (context, state) {
        if (state is AlzahimarSuccess) {
          if (state.prediction == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WariningresultAlzahimar()));
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SafeResultAlzhimar()));
          }
        } else if (state is AlzahimarError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
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
                Text('Step 4 of 4 — Cognitive Symptoms', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: const Color(0xffF9F9FB), borderRadius: BorderRadius.circular(25), border: Border.all(color: const Color(0xffEDEDED)), boxShadow: const [BoxShadow(color: Color(0xffFFFFFF), blurRadius: 5, offset: Offset(0, 3))]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const SizedBox(height: 10),
                      Text('Cognitive Symptoms', style: GoogleFonts.inter(fontSize: 24, color: const Color(0xff242424), fontWeight: FontWeight.w500)),
                      const SizedBox(height: 20),
                      InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedMemoryComplaints = v), selectedValue: selectedMemoryComplaints, displayText: '', txt: "Memory Complaints"),
                      const SizedBox(height: 20),
                      InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedBehavioralProblems = v), selectedValue: selectedBehavioralProblems, displayText: '', txt: "Behavioral Problems"),
                      const SizedBox(height: 20),
                      InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedConfusion = v), selectedValue: selectedConfusion, displayText: '', txt: "Confusion"),
                      const SizedBox(height: 20),
                      InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedDisorientation = v), selectedValue: selectedDisorientation, displayText: '', txt: "Disorientation"),
                      const SizedBox(height: 20),
                      InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedPersonalityChanges = v), selectedValue: selectedPersonalityChanges, displayText: '', txt: "Personality Changes"),
                      const SizedBox(height: 20),
                      InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedDifficultyTasks = v), selectedValue: selectedDifficultyTasks, displayText: '', txt: "Difficulty Completing Tasks"),
                      const SizedBox(height: 20),
                      InputDropDownButton(items: yesNo, onChanged: (v) => setState(() => selectedForgetfulness = v), selectedValue: selectedForgetfulness, displayText: '', txt: "Forgetfulness"),
                      const SizedBox(height: 10),
                    ]),
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<AlzahimarCubit, AlzahimarState>(
                  builder: (context, state) {
                    final isLoading = state is AlzahimarLoading;
                    return SizedBox(
                      width: double.infinity, height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: const Color(0xff1976D2)),
                        onPressed: isLoading ? null : () {
                          final cubit = context.read<AlzahimarCubit>();
                          cubit.memoryComplaints = selectedMemoryComplaints ?? "No";
                          cubit.behavioralProblems = selectedBehavioralProblems ?? "No";
                          cubit.confusion = selectedConfusion ?? "No";
                          cubit.disorientation = selectedDisorientation ?? "No";
                          cubit.personalityChanges = selectedPersonalityChanges ?? "No";
                          cubit.difficultyTasks = selectedDifficultyTasks ?? "No";
                          cubit.forgetfulness = selectedForgetfulness ?? "No";
                          cubit.predict();

                        },
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('Predict', style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}