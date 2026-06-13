part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileLoading extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  final UserModel userModel;
  GetProfileSuccess(this.userModel);
}

final class GetProfileError extends ProfileState {
  final String message;
  GetProfileError(this.message);
}

final class PickProfileImageLoading extends ProfileState {}

final class PickProfileImageSuccess extends ProfileState {
  final File image;
  PickProfileImageSuccess(this.image);
}

final class PickProfileImageError extends ProfileState {
  final String message;
  PickProfileImageError(this.message);
}

final class UpdateProfileImageLoading extends ProfileState {}

final class UpdateProfileImageSuccess extends ProfileState {}

final class UpdateProfileImageError extends ProfileState {
  final String message;
  UpdateProfileImageError(this.message);
}

final class ProfileUserLoading extends ProfileState {}

final class ProfileUserSuccess extends ProfileState {}

final class ProfileUsereError extends ProfileState {
  final String message;
  ProfileUsereError(this.message) {
    log("GetProfileError: $message");
    // ✅ زود ده
  }
}
