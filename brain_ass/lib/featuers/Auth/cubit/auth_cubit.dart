import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? tempName;

  // ================= REGISTER =================
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());

      tempName = name;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.sendEmailVerification();

      emit(RegisterSuccess("Check your email to verify account"));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  // ================= CHECK VERIFY =================
  Future<bool> isVerified() async {
    final user = auth.currentUser;
    await user!.reload();
    return user.emailVerified;
  }

  // ================= SAVE TO FIRESTORE =================
  Future<void> saveUserToFirestore() async {
    final user = auth.currentUser;

    await firestore.collection('users').doc(user!.email).set({
      "name": tempName ?? "",
      "email": user.email,
      "image": "", // ✅ الحل
    });

    emit(SaveUserSuccess("User saved successfully"));
  }

  // ================= LOGIN =================
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoading());

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.reload();

      if (!userCredential.user!.emailVerified) {
        await auth.signOut();
        emit(LoginError("Please verify your email first"));
        return;
      }

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.code));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  // ================= FORGOT PASSWORD =================
  forgotPassword({required String email}) async {
    try {
      emit(ForgotPasswordLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgotPasswordSuccess("Password reset link sent to $email"));
    } on FirebaseAuthException catch (e) {
      emit(ForgotPasswordError(e.message ?? "Failed to send reset link"));
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  // ================= UPDATE PROFILE =================
  updateProfile({String? name}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      emit(UpdateProfileLoading());

      if (name != null && name.isNotEmpty) {
        await user.updateDisplayName(name);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .update({'name': name});
      }

      emit(UpdateProfileSuccess("Profile updated successfully"));
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }
}