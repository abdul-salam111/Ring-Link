import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trainer_home_screen_event.dart';
part 'trainer_home_screen_state.dart';

class TrainerHomeScreenBloc
    extends Bloc<TrainerHomeScreenEvent, TrainerHomeScreenState> {
  TrainerHomeScreenBloc() : super(TrainerHomeScreenState()) {
    on<ArtistHomeTabChanged>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.currentTabIndex));
    });
  }
}
