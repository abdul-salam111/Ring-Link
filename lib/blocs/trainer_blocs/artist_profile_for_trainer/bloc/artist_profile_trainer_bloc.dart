import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'artist_profile_trainer_event.dart';
part 'artist_profile_trainer_state.dart';

class ArtistProfileTrainerBloc extends Bloc<ArtistProfileTrainerEvent, ArtistProfileTrainerState> {
  ArtistProfileTrainerBloc() : super(ArtistProfileTrainerInitial()) {
     on<ArtistProfileTabChanged>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.currentTabIndex));
    });
  }
}
