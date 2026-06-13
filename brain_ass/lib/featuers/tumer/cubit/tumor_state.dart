abstract class TumorState {}

class TumorInitial extends TumorState {}

class TumorLoading extends TumorState {}

class TumorSuccess extends TumorState {
  final String result;
  final double confidence;

  TumorSuccess(this.result, this.confidence);
}

class TumorError extends TumorState {
  final String message;

  TumorError(this.message);
}