import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/repositories/common_repositories/auth_repository.dart';
import 'package:ring_link/services/storage.dart';
import 'package:ring_link/utils/enums.dart';

part 'chooserole_event.dart';
part 'chooserole_state.dart';

class ChooseroleBloc extends Bloc<ChooseroleEvent, ChooseroleState> {
  AuthRepository artistAuthRepository;
  ChooseroleBloc(this.artistAuthRepository) : super(ChooseroleState()) {
    on<ChooseRoleChanged>(_onChooseRoleChanged);
  }
  void _onChooseRoleChanged(
      ChooseRoleChanged event, Emitter<ChooseroleState> emit) {
    emit(state.copyWith(chooseRole: event.chooseRole));
  }
}
