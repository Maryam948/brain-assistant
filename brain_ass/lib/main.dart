// main.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled3/database/cash_helper.dart';
import 'package:untitled3/featuers/alzahiemer/cubit/alzahimer_cubit.dart';
import 'package:untitled3/featuers/profile/views/update_imag.dart';
import 'package:untitled3/featuers/tumer/cubit/tumor_cubit.dart';
import 'package:untitled3/pages/alzahimar_predict.dart';
import 'firebase_options.dart';
import 'featuers/Auth/cubit/auth_cubit.dart';
import 'featuers/Auth/view/signin.dart';
import 'featuers/Auth/view/signup.dart';
import 'featuers/Auth/view/verfiy.dart';
import 'pages/splash.dart';
import 'pages/home.dart';
import 'pages/onboarding.dart';
import 'featuers/Auth/view/forget.dart';
import 'pages/stroke predict.dart';
import 'pages/stroke predict2.dart';
import 'featuers/detect/view/stroke_detect.dart';
import 'featuers/profile/views/profile_page.dart';
import 'pages/alzahimar_predict2.dart';
import 'pages/alzahimar_predict3.dart';
import 'pages/alzahimar_predict4.dart';
import 'featuers/tumer/view/tumar_detect.dart';
import 'featuers/tumer/view/tumar_detect green.dart';
import 'featuers/tumer/view/tumar_detect red.dart';
import 'pages/saferesult.dart';
import 'pages/wariningresult.dart';
import 'pages/wariningresult_alzahimar.dart';
import 'pages/chat_bot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://omlzzdxwrxdaslapktkc.supabase.co',
    anonKey: 'sb_publishable_1ybengDNtlZvL8ntiqCRKQ_6kWlqIup',
  );
  await CashHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => TumorCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: user == null ? Splash.routeName : Home.routeName,
        onGenerateRoute: (settings) {
          // ── Alzheimer routes — كلهم بيشاركوا نفس الـ AlzahimarCubit ──
          if (settings.name == AlzahimarPredict.routeName ||
              settings.name == AlzahimarPredict2.routeName ||
              settings.name == AlzahimarPredict3.routeName ||
              settings.name == AlzahimarPredict4.routeName) {
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => BlocProvider(
                create: (_) => AlzahimarCubit(),
                child: _alzahimarPage(settings.name!),
              ),
            );
          }
          return null; // باقي الـ routes بتشتغل عادي
        },
        routes: {
          Splash.routeName: (_) => const Splash(),
          Onboarding.routeName: (_) => const Onboarding(),
          Signup.routeName: (_) => const Signup(),
          Signin.routeName: (_) => const Signin(),
          Forget.routeName: (_) => const Forget(),
          Verfiy.routeName: (_) => const Verfiy(),
          Home.routeName: (_) => const Home(),
          Strokepredict.routeName: (_) => const Strokepredict(),
          Strokepredict2.routeName: (_) => const Strokepredict2(),
          StrokeDetect.routeName: (_) => const StrokeDetect(),
          TumerDetect.routeName: (_) => const TumerDetect(),
          TumatDetectGreen.routeName: (_) => const TumatDetectGreen(),
          TumatDetectRed.routeName: (_) => const TumatDetectRed(),
          Saferesult.routeName: (_) => const Saferesult(),
          Wariningresult.routeName: (_) => const Wariningresult(),
          WariningresultAlzahimar.routeName: (_) =>
              const WariningresultAlzahimar(),
          ProfilePage.routeName: (_) => const ProfilePage(),
          ChatBot.routeName: (_) => const ChatBot(),
          UpdateImage.routeName: (_) => const UpdateImage(),
        },
      ),
    );
  }

  Widget _alzahimarPage(String routeName) {
    switch (routeName) {
      case AlzahimarPredict.routeName:
        return const AlzahimarPredict();
      case AlzahimarPredict2.routeName:
        return const AlzahimarPredict2();
      case AlzahimarPredict3.routeName:
        return const AlzahimarPredict3();
      case AlzahimarPredict4.routeName:
        return const AlzahimarPredict4();
      default:
        return const AlzahimarPredict();
    }
  }
}
