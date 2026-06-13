part of 'detect_cubit.dart';

@immutable
sealed class DetectState {}

final class DetectInitial extends DetectState {}

class DetectionLoading extends DetectState {}

class DetectionSuccess extends DetectState {
  final String prediction;
  DetectionSuccess(this.prediction);
}

class DetectionError extends DetectState {
  final String message;
  DetectionError(this.message);
}
