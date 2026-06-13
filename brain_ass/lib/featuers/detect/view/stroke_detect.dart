import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/featuers/detect/cubit/detect_cubit.dart';

class StrokeDetect extends StatefulWidget {
  static const String routeName = '/stroke_detect';

  const StrokeDetect({super.key});

  @override
  State<StrokeDetect> createState() => _StrokeDetectState();
}

class _StrokeDetectState extends State<StrokeDetect> {
  File? profileImage;

  // ================= PICK IMAGE =================
  pickImage() async {
    XFile? xFileImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (xFileImage != null) {
      setState(() {
        profileImage = File(xFileImage.path);
      });
    }
  }

  // ================= COLORS =================
  Color getColor(String? prediction) {
    if (prediction == "Normal") return const Color(0xff5CE65C);
    if (prediction == "Ischemic") return const Color(0xffFAA13C);
    if (prediction == "Haemorrhagic") return const Color(0xffB71C1C);
    return Colors.white;
  }

  // ================= ICONS =================
  IconData getIcon(String? prediction) {
    if (prediction == "Normal") return Icons.check_circle_outline;
    if (prediction == "Ischemic") return Icons.warning_amber_outlined;
    if (prediction == "Haemorrhagic") return Icons.dangerous_outlined;
    return Icons.info_outline;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetectCubit(),
      child: BlocConsumer<DetectCubit, DetectState>(
        listener: (context, state) {
          if (state is DetectionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<DetectCubit>();
          final isLoading = state is DetectionLoading;
          final prediction =
              state is DetectionSuccess ? state.prediction : null;

          return Scaffold(
            backgroundColor: Colors.white,
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
                padding: const EdgeInsets.only(
                    top: 133, bottom: 136, right: 38, left: 38),
                child: Column(
                  children: [
                    Text(
                      'Upload Brain Scan',
                      style: GoogleFonts.inter(
                        fontSize: 35,
                        color: const Color(0xff242424),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'Upload a clear brain scan',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: const Color(0xff68707C),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 80),

                    // ================= IMAGE =================
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: 324,
                        height: 324,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xff8EC1FE),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: profileImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.file(
                                  profileImage!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 26),
                                  Image.asset(
                                    'Assets/detect.png',
                                    width: 75,
                                    height: 83,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Tap or drag to upload',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      color: const Color(0xff07294C),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'JPG , PNG , DICOM (optional)',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: const Color(0xff68707C),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 80),

                    // ================= BUTTON =================
                    TextButton(
                      onPressed: profileImage == null || isLoading
                          ? null
                          : () => cubit.detectStroke(profileImage!),

                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff247CFF),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(362, 60),
                        padding:
                            const EdgeInsets.fromLTRB(12, 14, 12, 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Detection",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),

                    const SizedBox(height: 40),

                    // ================= RESULT =================
                    if (prediction != null)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: getColor(prediction),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prediction,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              getIcon(prediction),
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}