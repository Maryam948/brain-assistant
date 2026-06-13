import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:untitled3/featuers/tumer/cubit/tumor_cubit.dart';
import 'package:untitled3/featuers/tumer/cubit/tumor_state.dart';
import 'package:untitled3/featuers/tumer/view/tumar_detect green.dart';
import 'package:untitled3/featuers/tumer/view/tumar_detect red.dart';

class TumerDetect extends StatefulWidget {
  static const String routeName = '/tumar_detect';

  const TumerDetect({super.key});

  @override
  State<TumerDetect> createState() => _TumerDetectState();
}

class _TumerDetectState extends State<TumerDetect> {
  File? profileImage;

  bool _isDialogShowing = false;

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

  void _showLoading() {
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _hideLoading() {
    if (_isDialogShowing) {
      Navigator.pop(context);
      _isDialogShowing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TumorCubit, TumorState>(
      listener: (context, state) async {
        if (state is TumorLoading) {
          _showLoading();
        }

        if (state is TumorSuccess) {
          _hideLoading();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.result == "Tumor") {
              Navigator.pushNamed(context, TumatDetectRed.routeName);
            } else {
              Navigator.pushNamed(context, TumatDetectGreen.routeName);
            }
          });
        }

        if (state is TumorError) {
          _hideLoading();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
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
                top: 133,
                bottom: 136,
                right: 38,
                left: 38,
              ),
              child: Column(
                children: [
                  Text(
                    'Brain Tumor Scan',
                    style: GoogleFonts.inter(
                      fontSize: 38,
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
                      ),
                      child: profileImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                profileImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  TextButton(
                    onPressed: () {
                      if (profileImage != null) {
                        context.read<TumorCubit>().predict(profileImage!);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      fixedSize: const Size(362, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Detection"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}