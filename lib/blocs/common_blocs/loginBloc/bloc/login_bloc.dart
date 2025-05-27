import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/repositories/artist_repositories/artist_auth_repository/artist_auth_repository.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/enums.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ArtistAuthRepository artistAuthRepository;
  LoginBloc(this.artistAuthRepository) : super(LoginState()) {
    on<EmailChangedLogin>(changeEmail);
    on<PasswordChangedLogin>(changePassword);
    on<OnLoginUserEvent>(onLoginUser);
  }

  void changeEmail(EmailChangedLogin event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void changePassword(PasswordChangedLogin event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> onLoginUser(
      OnLoginUserEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      final email = state.email.toString().trim();
      final password = state.password.toString().trim();
      await artistAuthRepository
          .signInArtistWithEmailAndPassword(email: email, password: password)
          .then((getartistDetails) async {
        await SessionController().saveUserInStorage(getartistDetails);
        await SessionController().getUserfromSharedpref();
        emit(state.copyWith(
            message: "LoggedIn Successfully", apiStatus: ApiStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(message: e.toString(), apiStatus: ApiStatus.error));
    }
  }
}
