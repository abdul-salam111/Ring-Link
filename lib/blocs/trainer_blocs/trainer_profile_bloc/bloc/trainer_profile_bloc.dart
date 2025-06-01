import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trainer_profile_event.dart';
part 'trainer_profile_state.dart';

class TrainerProfileBloc extends Bloc<TrainerProfileEvent, TrainerProfileState> {
  TrainerProfileBloc() : super(TrainerProfileState()) {
     on<ChangeTrainerProfileTab>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.currentTabIndex));
    });
  }
}
