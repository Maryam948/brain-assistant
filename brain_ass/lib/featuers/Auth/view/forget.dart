import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/featuers/Auth/cubit/auth_cubit.dart';
import 'package:untitled3/featuers/Auth/cubit/auth_state.dart';
import 'package:untitled3/widgets/email_text_field.dart';

class Forget extends StatefulWidget {
  static const String routeName = '/forget';
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onContinuePressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(
        email: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // ── Loading Modal ──────────────────────────────────────
        if (state is ForgotPasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const _LoadingDialog(),
          );
        } else {
          // أغلق اللودينج لو كان مفتوح
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }

        // ── Success ────────────────────────────────────────────
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          // ارجع للصفحة السابقة أو Home حسب تدفق التطبيق
          Navigator.of(context).pop();
        }

        // ── Error ──────────────────────────────────────────────
        if (state is ForgotPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          backgroundColor: const Color(0xffFFFFFF),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("Assets/forget.gif"),
                      fit: BoxFit.cover,
                      width: 497,
                      height: 373,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff242424),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      "Enter your email and we'll send \nyou a new password.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xff757575),
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 38),
                    EmailTextField(
                      controller: _emailController,
                      formkey: _formKey,
                    ),
                    const SizedBox(height: 56),
                    TextButton(
                      onPressed: state is ForgotPasswordLoading
                          ? null
                          : () => _onContinuePressed(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        fixedSize: const Size(362, 60),
                        padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Loading Dialog Widget ────────────────────────────────────────
class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              "Sending reset link...",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff242424),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Please wait a moment",
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xff757575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
