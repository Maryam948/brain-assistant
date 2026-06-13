// features/alzahimar/cubit/alzahimar_state.dart

abstract class AlzahimarState {}

class AlzahimarInitial extends AlzahimarState {}

class AlzahimarLoading extends AlzahimarState {}

class AlzahimarSuccess extends AlzahimarState {
  final int prediction;
  final List<double> probability;

  AlzahimarSuccess({required this.prediction, required this.probability});
}

class AlzahimarError extends AlzahimarState {
  final String message;
  AlzahimarError(this.message);
}