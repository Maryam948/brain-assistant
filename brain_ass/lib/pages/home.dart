import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/profile/cubit/profile_cubit.dart';
import 'package:untitled3/featuers/profile/views/profile_page.dart';
import 'package:untitled3/pages/chat_bot.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUsers(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ Hello + اسم اليوزر من BLoC
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              String userName = "...";
                              if (state is GetProfileSuccess) {
                                userName = state.userModel.name;
                              }
                              return Text(
                                "Hello $userName 👋🏻",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff11424D),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),

                          Text(
                            "Brain Health Assistant",
                            style: GoogleFonts.poppins(
                              color: const Color(0xff757575),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProfilePage();
                              },
                            ),
                          );
                        },
                        // ✅ صورة البروفايل بقت ديناميكية
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            String? userImage;
                            if (state is GetProfileSuccess) {
                              userImage = state.userModel.image;
                            }
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: (userImage != null &&
                                      userImage.isNotEmpty)
                                  ? Image.network(
                                      userImage,
                                      fit: BoxFit.cover,
                                      width: 55.82108688354492,
                                      height: 56,
                                    )
                                  : Image(
                                      image: const AssetImage(
                                          'Assets/profile.jpg'),
                                      fit: BoxFit.cover,
                                      width: 55.82108688354492,
                                      height: 56,
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 42),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage('Assets/robot.png'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 167,
                    ),
                  ),
                  const SizedBox(height: 53),
                  Text(
                    "Brain Disease Models",
                    style: GoogleFonts.poppins(
                      color: const Color(0xff242424),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/stroke_predict');
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 24,
                                    left: 10,
                                    right: 10,
                                    bottom: 36,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                              'Assets/braincard1.png',
                                            ),
                                            fit: BoxFit.cover,
                                            width: 56,
                                            height: 39,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            "Stroke Risk \nPrediction",
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xff242424),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Check your stroke risk \nusing health data",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff757575),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/stroke_detect');
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 24,
                                    left: 10,
                                    right: 10,
                                    bottom: 36,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image:
                                                AssetImage('Assets/card2.png'),
                                            fit: BoxFit.cover,
                                            width: 56,
                                            height: 39,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            "Stroke MRI \nDetection",
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xff242424),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Upload brain MRI\n to detect stroke signs",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff757575),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/alzahimar_predict',
                                );
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 24,
                                    left: 10,
                                    right: 10,
                                    bottom: 36,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                              'Assets/braincard3.png',
                                            ),
                                            fit: BoxFit.cover,
                                            width: 56,
                                            height: 39,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            "Alzheimer \nPrediction",
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xff242424),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Check your alzheimer risk\nusing health data",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff757575),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/tumar_detect');
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 24,
                                    left: 10,
                                    right: 2,
                                    bottom: 36,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                              'Assets/braincard4.png',
                                            ),
                                            fit: BoxFit.cover,
                                            width: 56,
                                            height: 39,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            "Brain Tumor \nDetection",
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xff242424),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Classify brain tumors \nfrom MRI images",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff757575),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffEDEDED),
          shape: CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatBot();
                },
              ),
            );
          },
          child: Image.asset('Assets/rebot_floating.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}