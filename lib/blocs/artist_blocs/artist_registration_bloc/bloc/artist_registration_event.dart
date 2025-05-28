part of 'artist_registration_bloc.dart';

abstract class ArtistRegistrationEvent extends Equatable {
  const ArtistRegistrationEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends ArtistRegistrationEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends ArtistRegistrationEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends ArtistRegistrationEvent {
  final String confirmpassword;

  const ConfirmPasswordChanged(this.confirmpassword);

  @override
  List<Object> get props => [confirmpassword];
}

class UsernameChanged extends ArtistRegistrationEvent {
  final String username;

  const UsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class TermsAndConditionsAgreed extends ArtistRegistrationEvent {
  final bool termsAndConditionsAgreed;

  const TermsAndConditionsAgreed(this.termsAndConditionsAgreed);

  @override
  List<Object> get props => [termsAndConditionsAgreed];
}

class OnArtistRegistrationEvent extends ArtistRegistrationEvent {}
