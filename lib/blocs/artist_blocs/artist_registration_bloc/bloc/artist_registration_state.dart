part of 'artist_registration_bloc.dart';

class ArtistRegistrationState extends Equatable {
  final String? email;
  final String? username;
  final String? password;
  final String? confirmPassword;
  final ApiStatus apiStatus;
  final String message;
  const ArtistRegistrationState({
    this.email = "",
    this.password = "",
    this.apiStatus = ApiStatus.initial,
    this.message = '',
    this.username = "",
    this.confirmPassword = "",
  });

  //copywith method to create a new instance with updated values
  ArtistRegistrationState copyWith({
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    ApiStatus? apiStatus,
    String? message,
  }) {
    return ArtistRegistrationState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props =>
      [email!, username!, password!, confirmPassword!, apiStatus, message];
}


