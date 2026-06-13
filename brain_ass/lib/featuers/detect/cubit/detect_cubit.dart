import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'detect_state.dart';

class DetectCubit extends Cubit<DetectState> {
  DetectCubit() : super(DetectInitial());

  Future<void> detectStroke(File image) async {
    emit(DetectionLoading());

    try {
      final dio = Dio();

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await dio.post(
        'http://10.0.2.2:5000/predict_stroke_mri',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(
          DetectionSuccess(
            response.data['prediction'],
          ),
        );
      } else {
        emit(
          DetectionError(
            'Server error: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(DetectionError(e.toString()));
    }
  }
}
