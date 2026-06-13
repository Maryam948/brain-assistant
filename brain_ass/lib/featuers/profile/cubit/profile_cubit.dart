import 'dart:io';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled3/database/cash_helper.dart';
import 'package:untitled3/featuers/profile/data/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  getUsers() async {
    try {
      emit(GetProfileLoading());

      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      log("User data from Firestore: ${userDoc.data()}");

      final data = userDoc.data()!;

      // ✅ زود ده
      log("name type: ${data['name'].runtimeType}, value: ${data['name']}");
      log("email type: ${data['email'].runtimeType}, value: ${data['email']}");
      log("image type: ${data['image'].runtimeType}, value: ${data['image']}");

      Map<String, dynamic> updates = {};
      if (!data.containsKey('image')) updates['image'] = '';
      if (!data.containsKey('name')) updates['name'] = '';
      if (!data.containsKey('email')) {
        updates['email'] = FirebaseAuth.instance.currentUser!.email ?? '';
      }

      if (updates.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update(updates);

        userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get();
      }

      UserModel userModel = UserModel.fromJson(userDoc.data()!);
      emit(GetProfileSuccess(userModel));
    } catch (e) {
      emit(GetProfileError(e.toString()));
      log(e.toString());
    }
  }

  String? path;
  File? profileImge;
  String? url;
  SupabaseClient supabase = Supabase.instance.client;

  pickImage() async {
    emit(PickProfileImageLoading());
    XFile? xFileImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (xFileImage != null) {
      // ✅ نسخ الملف لمكان دائم بدل الاعتماد على الـ cache المؤقت
      final tempDir = await getApplicationDocumentsDirectory();
      final newPath = '${tempDir.path}/${basename(xFileImage.path)}';
      final newFile = await File(xFileImage.path).copy(newPath);

      profileImge = newFile;
      emit(PickProfileImageSuccess(profileImge!));
    } else {
      emit(PickProfileImageError("No image selected"));
    }
  }

  uploadImageToSupabase() async {
    try {
      if (profileImge == null || !await profileImge!.exists()) {
        log("Image file does not exist!");
        return null;
      }

      path = basename(profileImge!.path);
      DateTime date = DateTime.now();
      await supabase.storage
          .from("bain_ass")
          .upload("${path!}_$date", profileImge!);
      url = supabase.storage.from("bain_ass").getPublicUrl("${path!}_$date");
      return url;
    } catch (e) {
      log("UPLOAD ERROR: ${e.toString()}");
      return null;
    }
  }

  UpdateImageProfile() async {
    try {
      emit(UpdateProfileImageLoading());

      final imageUrl = await uploadImageToSupabase();

      if (imageUrl == null) {
        emit(UpdateProfileImageError("Failed to upload image"));
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({'image': imageUrl});
      await CashHelper.saveData(key: 'image', value: url);
      emit(UpdateProfileImageSuccess());
    } catch (e) {
      emit(UpdateProfileImageError(e.toString()));
      log(e.toString());
    }
  }
}
