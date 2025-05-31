import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ring_link/models/trainers/get_models/get_trainer_details_model.dart';
import 'package:ring_link/utils/enums.dart';

import '../../../../repositories/artist_repositories/artist_home_screen/artist_home_screen_repository.dart';
part 'artist_home_event.dart';
part 'artist_home_state.dart';

class ArtistHomeBloc extends Bloc<ArtistHomeEvent, ArtistHomeState> {
  ArtistHomeScreenRepository artistHomeScreenRepository;
  ArtistHomeBloc(this.artistHomeScreenRepository) : super(ArtistHomeState()) {
    on<ArtistHomeTabChanged>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.currentTabIndex));
    });
    on<SelectLocation>((event, emit) {
      emit(state.copyWith(selectedLocation: event.location));
    });
    on<SelectLevel>((event, emit) {
      emit(state.copyWith(selectedLevel: event.selectedLevel));
    });
    on<SelectPriceRange>((event, emit) {
      emit(state.copyWith(selectedRange: event.selectedRange));
    });
    on<SelectMinimumRating>((event, emit) {
      emit(state.copyWith(minimumRating: event.minimumRating));
    });
    on<SelectAvailability>((event, emit) {
      emit(state.copyWith(avialibility: event.availability));
    });
    on<SelectSessionType>((event, emit) {
      emit(state.copyWith(sessionType: event.sessionType));
    });
    on<SelectVirtualTraining>((event, emit) {
      emit(state.copyWith(virtualTraining: event.virtualTraining));
    });

    on<SearchTrainerEvent>((event, emit) {
      if (event.searchQuery.isEmpty) {
        // If search is empty, show all artists
        emit(state.copyWith(
          allTrainersData: state.allTrainersDataForFilteration,
        ));
      } else {
        // Filter artists based on search query
        final filteredArtists =
            state.allTrainersDataForFilteration.where((artist) {
          final name = artist.trainerUsername?.toLowerCase() ?? '';
          final query = event.searchQuery.toLowerCase();
          return name.contains(query);
        }).toList();

        emit(state.copyWith(
          allTrainersData: filteredArtists,
        ));
      }
    });

    on<FetchAllTrainerEvent>(fetAllTrainers);
  }

  Future<void> fetAllTrainers(
      FetchAllTrainerEvent event, Emitter<ArtistHomeState> emit) async {
    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      await artistHomeScreenRepository.fetchAllTrainers().then((trainers) {
        emit(state.copyWith(
          apiStatus: ApiStatus.success,
          allTrainersData: trainers,
          allTrainersDataForFilteration: trainers,
          message: "Fetch Successflly!",
        ));
      });
    } catch (e) {
      emit(state.copyWith(apiStatus: ApiStatus.error, message: e.toString()));
    }
  }

  
}
