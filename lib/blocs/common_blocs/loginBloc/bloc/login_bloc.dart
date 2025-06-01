import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/repositories/common_repositories/auth_repository.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/services/storage.dart';
import 'package:ring_link/utils/enums.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository artistAuthRepository;
  LoginBloc(this.artistAuthRepository) : super(LoginState()) {
    on<EmailChangedLogin>(changeEmail);
    on<PasswordChangedLogin>(changePassword);
    on<OnLoginUserEvent>(onLoginUser);
    on<RememberMeEvent>(onRememberMe);
  }

  void changeEmail(EmailChangedLogin event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void changePassword(PasswordChangedLogin event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void onRememberMe(RememberMeEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: event.rememberMe));
  }

  Future<void> onLoginUser(
      OnLoginUserEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      final email = state.email.toString().trim();
      final password = state.password.toString().trim();
      await artistAuthRepository
          .signInArtistWithEmailAndPassword(email: email, password: password)
          .then((getUserDetails) async {
        final userType = await getUserDetails is GetArtistDetails
            ? UserType.artist.name
            : UserType.trainer.name;

        await storage.setValues(StorageKeys.userType, userType);
        await SessionController().saveUserInStorage(getUserDetails);
        await SessionController().getUserfromSharedpref();

        emit(state.copyWith(
          message: "LoggedIn Successfully",
          apiStatus: ApiStatus.success,
        ));
      });
    } catch (e) {
      emit(state.copyWith(message: e.toString(), apiStatus: ApiStatus.error));
    }
  }
}
