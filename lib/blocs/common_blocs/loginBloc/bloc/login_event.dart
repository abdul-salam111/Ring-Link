part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedLogin extends LoginEvent {
  final String email;

  const EmailChangedLogin(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChangedLogin extends LoginEvent {
  final String password;

  const PasswordChangedLogin(this.password);

  @override
  List<Object> get props => [password];
}

class RememberMeEvent extends LoginEvent {
  final bool rememberMe;

  const RememberMeEvent(this.rememberMe);

  @override
  List<Object> get props => [rememberMe];
}

class OnLoginUserEvent extends LoginEvent {}
