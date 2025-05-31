import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/repositories/trainer_repsitories/trainer_homescreen_repository.dart';
import 'package:ring_link/utils/enums.dart';

part 'trainer_home_screen_event.dart';
part 'trainer_home_screen_state.dart';

class TrainerHomeScreenBloc
    extends Bloc<TrainerHomeScreenEvent, TrainerHomeScreenState> {
  TrainerHomescreenRepository trainerHomescreenRepository;
  TrainerHomeScreenBloc(this.trainerHomescreenRepository)
      : super(TrainerHomeScreenState()) {
    on<ArtistHomeTabChanged>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.currentTabIndex));
    });

    // In trainer_home_screen_bloc.dart, add this to the event handlers
    on<SearchArtistEvent>((event, emit) {
      if (event.searchQuery.isEmpty) {
        // If search is empty, show all artists
        emit(state.copyWith(
          allArtistData: state.allArtistsDataForFilteration,
        ));
      } else {
        // Filter artists based on search query
        final filteredArtists =
            state.allArtistsDataForFilteration.where((artist) {
          final name = artist.artistName?.toLowerCase() ?? '';
          final query = event.searchQuery.toLowerCase();

          return name.contains(query);
        }).toList();

        emit(state.copyWith(
          allArtistData: filteredArtists,
        ));
      }
    });

    //fetch all artists
    on<FetchAllArtistEvent>(fetAllArtists);
  }

  Future<void> fetAllArtists(
      FetchAllArtistEvent event, Emitter<TrainerHomeScreenState> emit) async {
    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      await trainerHomescreenRepository.fetchAllArtists().then((trainers) {
        emit(state.copyWith(
          apiStatus: ApiStatus.success,
          allArtistData: trainers,
          allArtistsDataForFilteration: trainers,
          message: "Fetch Successflly!",
        ));
      });
    } catch (e) {
      emit(state.copyWith(apiStatus: ApiStatus.error, message: e.toString()));
    }
  }
}
