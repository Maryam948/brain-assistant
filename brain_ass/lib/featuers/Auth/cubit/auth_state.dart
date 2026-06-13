import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

/// REGISTER
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final String message;
  RegisterSuccess(this.message);
}

class RegisterError extends AuthState {
  final String message;
  RegisterError(this.message);
}

/// LOGIN
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

/// VERIFY
class VerifyEmailSent extends AuthState {
  final String message;
  VerifyEmailSent(this.message);
}

/// SAVE USER
class SaveUserSuccess extends AuthState {
  final String message;
  SaveUserSuccess(this.message);
}
class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final String message;
  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordError extends AuthState {
  final String error;
  ForgotPasswordError(this.error);
}
final class UpdateProfileLoading extends AuthState {}
final class UpdateProfileSuccess extends AuthState {
  final String message;
  UpdateProfileSuccess(this.message);
}
final class UpdateProfileError extends AuthState {
  final String message;
  UpdateProfileError(this.message);
}