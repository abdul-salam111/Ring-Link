import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/models/trainers/post_models/create_trainer_model.dart';
import 'package:ring_link/repositories/common_repositories/auth_repository.dart';
import 'package:ring_link/services/storage.dart';
import 'package:ring_link/utils/enums.dart';

import '../../../../models/artists/post_models/create_artist_model.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  AuthRepository artistAuthRepository;
  RegistrationBloc(this.artistAuthRepository) : super(RegistrationState()) {
    on<EmailChanged>(changeEmail);
    on<PasswordChanged>(changePassword);
    on<ConfirmPasswordChanged>(changeConfirmPassword);
    on<UsernameChanged>(changeUsername);
    on<OnUserRegistrationEvent>(onArtistRegistrationEvent);
    on<TermsAndConditionsAgreed>(onTermsAndConditionAgree);
  }

  void changeEmail(EmailChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void changePassword(PasswordChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void changeConfirmPassword(
      ConfirmPasswordChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmpassword));
  }

  void onTermsAndConditionAgree(
      TermsAndConditionsAgreed event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
        termsAndConditionsAgreed: event.termsAndConditionsAgreed));
  }

  void changeUsername(UsernameChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(username: event.username));
  }

  Future<void> onArtistRegistrationEvent(
      OnUserRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      final deviceToken= await storage.readValues(StorageKeys.deviceToken);
      final usertype = await storage.readValues(StorageKeys.userType);
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      if (usertype == UserType.artist.name) {
        final createArtistModel = CreateArtistModel(
          artistName: state.username.toString().trim(),
          artistEmail: state.email.toString().trim(),
          userType: usertype.toString(),
          createdAt: DateTime.now(),
          artist_device_token:deviceToken,
        );
        await artistAuthRepository.signUpUserWithEmailAndPassword(
            userEmail: state.email.toString().trim(),
            userPassword: state.password.toString().trim(),
            createArtist: createArtistModel);
      } else {
        final createTrainerModel = CreateTrainerModel(
          trainerUsername: state.username.toString().trim(),
          trainerEmail: state.email.toString().trim(),
          userType: usertype.toString(),
          createdAt: DateTime.now(),
          trainer_device_token: deviceToken,
        );
        await artistAuthRepository.signUpUserWithEmailAndPassword(
            userEmail: state.email.toString().trim(),
            userPassword: state.password.toString().trim(),
            createTrainer: createTrainerModel);
      }

      emit(state.copyWith(
          apiStatus: ApiStatus.success, message: 'Registration successful'));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), apiStatus: ApiStatus.error));
    }
  }
}
