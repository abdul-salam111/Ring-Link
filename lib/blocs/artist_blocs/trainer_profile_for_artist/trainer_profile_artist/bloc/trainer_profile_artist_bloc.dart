import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trainer_profile_artist_event.dart';
part 'trainer_profile_artist_state.dart';

class TrainerProfileArtistBloc extends Bloc<TrainerProfileArtistEvent, TrainerProfileArtistState> {
  TrainerProfileArtistBloc() : super(TrainerProfileArtistState()) {
   on<ChangeTrainerProfileTab>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.currentTabIndex));
    });
  }
}
