part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email = "",
      this.password = "",
      this.apiStatus = ApiStatus.initial,
      this.message = '',
      this.rememberMe = false});
  final String? email;
  final String? password;
  final ApiStatus apiStatus;
  final String message;
  final bool rememberMe;

  LoginState copyWith(
      {String? email,
      String? password,
      String? message,
      bool? rememberMe,
      ApiStatus? apiStatus}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        apiStatus: apiStatus ?? this.apiStatus,
        rememberMe: rememberMe ?? this.rememberMe,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [email!, password!, apiStatus, message, rememberMe];
}
