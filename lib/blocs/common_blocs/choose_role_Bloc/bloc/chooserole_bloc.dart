import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/repositories/artist_repositories/artist_auth_repository/artist_auth_repository.dart';
import 'package:ring_link/services/storage.dart';
import 'package:ring_link/utils/enums.dart';

part 'chooserole_event.dart';
part 'chooserole_state.dart';

class ChooseroleBloc extends Bloc<ChooseroleEvent, ChooseroleState> {
  ArtistAuthRepository artistAuthRepository;
  ChooseroleBloc(this.artistAuthRepository) : super(ChooseroleState()) {
    on<ChooseRoleChanged>(_onChooseRoleChanged);
    on<ChoosedRoleEvent>(updateUserTypeInFirebase);
  }
  void _onChooseRoleChanged(
      ChooseRoleChanged event, Emitter<ChooseroleState> emit) {
    emit(state.copyWith(chooseRole: event.chooseRole));
  }

  void updateUserTypeInFirebase(
      ChoosedRoleEvent event, Emitter<ChooseroleState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    await artistAuthRepository
        .updateUserRole(state.chooseRole.name)
        .then((value) {
      if (value == true) {
        emit(state.copyWith(
            apiStatus: ApiStatus.success,
            message: 'Role updated successfully'));
      } else {
        emit(state.copyWith(
            apiStatus: ApiStatus.error, message: 'Failed to update role'));
      }
    }).catchError((error) {
      emit(state.copyWith(
          apiStatus: ApiStatus.error, message: error.toString()));
    });
  }
}
