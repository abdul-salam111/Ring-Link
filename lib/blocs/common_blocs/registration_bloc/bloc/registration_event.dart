part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegistrationEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegistrationEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends RegistrationEvent {
  final String confirmpassword;

  const ConfirmPasswordChanged(this.confirmpassword);

  @override
  List<Object> get props => [confirmpassword];
}

class UsernameChanged extends RegistrationEvent {
  final String username;

  const UsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class TermsAndConditionsAgreed extends RegistrationEvent {
  final bool termsAndConditionsAgreed;

  const TermsAndConditionsAgreed(this.termsAndConditionsAgreed);

  @override
  List<Object> get props => [termsAndConditionsAgreed];
}

class OnUserRegistrationEvent extends RegistrationEvent {}

