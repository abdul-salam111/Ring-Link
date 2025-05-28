part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final String? email;
  final String? username;
  final String? password;
  final String? confirmPassword;
  final ApiStatus apiStatus;
  final String message;
  final bool termsAndConditionsAgreed;
  const RegistrationState({
    this.email = "",
    this.password = "",
    this.apiStatus = ApiStatus.initial,
    this.message = '',
    this.termsAndConditionsAgreed = false,
    this.username = "",
    this.confirmPassword = "",
  });

  //copywith method to create a new instance with updated values
  RegistrationState copyWith({
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    bool? termsAndConditionsAgreed,
    ApiStatus? apiStatus,
    String? message,
  }) {
    return RegistrationState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
      termsAndConditionsAgreed:
          termsAndConditionsAgreed ?? this.termsAndConditionsAgreed,
    );
  }

  @override
  List<Object> get props => [
        email!,
        username!,
        password!,
        confirmPassword!,
        apiStatus,
        message,
        termsAndConditionsAgreed
      ];
}
