import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/repositories/artist_repositories/artist_auth_repository/artist_auth_repository.dart';
import 'package:ring_link/utils/enums.dart';

import '../../../../models/artists/post_models/create_artist_model.dart';

part 'artist_registration_event.dart';
part 'artist_registration_state.dart';

class ArtistRegistrationBloc
    extends Bloc<ArtistRegistrationEvent, ArtistRegistrationState> {
  ArtistAuthRepository artistAuthRepository;
  ArtistRegistrationBloc(this.artistAuthRepository)
      : super(ArtistRegistrationState()) {
    on<EmailChanged>(changeEmail);
    on<PasswordChanged>(changePassword);
    on<ConfirmPasswordChanged>(changeConfirmPassword);
    on<UsernameChanged>(changeUsername);
    on<OnArtistRegistrationEvent>(onArtistRegistrationEvent);
    on<TermsAndConditionsAgreed>(onTermsAndConditionAgree);
  }

  void changeEmail(EmailChanged event, Emitter<ArtistRegistrationState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void changePassword(
      PasswordChanged event, Emitter<ArtistRegistrationState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void changeConfirmPassword(
      ConfirmPasswordChanged event, Emitter<ArtistRegistrationState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmpassword));
  }

  void onTermsAndConditionAgree(
      TermsAndConditionsAgreed event, Emitter<ArtistRegistrationState> emit) {
    emit(state.copyWith(
        termsAndConditionsAgreed: event.termsAndConditionsAgreed));
  }

  void changeUsername(
      UsernameChanged event, Emitter<ArtistRegistrationState> emit) {
    emit(state.copyWith(username: event.username));
  }

  Future<void> onArtistRegistrationEvent(OnArtistRegistrationEvent event,
      Emitter<ArtistRegistrationState> emit) async {
    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      final createArtistModel = CreateArtistModel(
        artistName: state.username.toString().trim(),
        artistEmail: state.email.toString().trim(),
        artistPassword: state.password.toString().trim(),
        artistConfirmPassword: state.confirmPassword.toString().trim(),
        createdAt: DateTime.now(),
      );
      await artistAuthRepository
          .signUpArtistWithEmailAndPassword(createArtistModel);
      emit(state.copyWith(
          apiStatus: ApiStatus.success, message: 'Registration successful'));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), apiStatus: ApiStatus.error));
    }
  }
}
