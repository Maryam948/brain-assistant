import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/database/cash_helper.dart';
import 'package:untitled3/featuers/profile/cubit/profile_cubit.dart';
import 'package:untitled3/featuers/profile/views/update_imag.dart';
import 'package:untitled3/pages/onboarding.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/ProfilePage';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUsers(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          log("Current state: $state"); // ✅ زود ده
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  // ── Loading ──────────────────────────────────
                  if (state is GetProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // ── Error ────────────────────────────────────
                  if (state is GetProfileError) {
                    return const Center(child: Text("Error loading profile"));
                  }

                  // ── Success ──────────────────────────────────
                  if (state is GetProfileSuccess) {
                    final user = state.userModel;
                    return SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 81, right: 20, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ── Title ─────────────────────────
                              Text(
                                "Profile",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff242424),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // ── Avatar ────────────────────────
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    UpdateImage.routeName,
                                    arguments: user.image,
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: const Color(0xffF5C6CB),
                                  // ✅ null-safe image
                                  backgroundImage: (user.image != null &&
                                          user.image!.isNotEmpty)
                                      ? NetworkImage(user.image!)
                                      : const AssetImage('Assets/profile.jpg')
                                          as ImageProvider,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // ── Name ──────────────────────────
                              Text(
                                user.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff242424),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // ── Email ─────────────────────────
                              Text(
                                user.email,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: const Color(0xff757575),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 40),

                              // ── Card ──────────────────────────
                              Container(
                                width: 362,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: const Color(0xff8EC1FE), width: 3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: SizedBox(
                                  height: 204,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Edit Profile Row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.edit_outlined,
                                                  color: Color(0xff6C19D2),
                                                  size: 35),
                                              const SizedBox(width: 15),
                                              Text(
                                                "Edit Profile",
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xff6C19D2),
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              final nameController =
                                                  TextEditingController();
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: const Text(
                                                      "Edit Profile"),
                                                  content: TextField(
                                                    controller: nameController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: "Name"),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text("Cancel"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        print(
                                                            "New Name: ${nameController.text}");
                                                        // ✅ Update في Firebase
                                                        final firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;
                                                        if (firebaseUser !=
                                                            null) {
                                                          await firebaseUser
                                                              .updateDisplayName(
                                                                  nameController
                                                                      .text);
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(firebaseUser
                                                                  .email)
                                                              .update({
                                                            'name':
                                                                nameController
                                                                    .text
                                                          });
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Save"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.arrow_forward,
                                                color: Color(0xff6C19D2),
                                                size: 35),
                                          ),
                                        ],
                                      ),

                                      const Divider(
                                        thickness: 1,
                                        color: Color(0xff6E7C8F),
                                        indent: 10,
                                        endIndent: 10,
                                      ),

                                      // Logout Row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.logout,
                                                  color: Color(0xffB71C1C),
                                                  size: 35),
                                              const SizedBox(width: 15),
                                              Text(
                                                "Logout",
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xffB71C1C),
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              // ✅ Clear cache وبعدين navigate
                                              await CashHelper.clearAll();
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Onboarding()),
                                                (route) => false,
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.arrow_forward,
                                                color: Color(0xffB71C1C),
                                                size: 35),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
