import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/serviece/tumer.dart';

import 'tumor_state.dart';

class TumorCubit extends Cubit<TumorState> {
  TumorCubit() : super(TumorInitial());

  Future<void> predict(File image) async {
    emit(TumorLoading());

    final response = await ApiService.sendImage(image);

    if (response != null) {
      emit(TumorSuccess(
        response["prediction"],
        response["confidence"],
      ));
    } else {
      emit(TumorError("Something went wrong"));
    }
  }
}
