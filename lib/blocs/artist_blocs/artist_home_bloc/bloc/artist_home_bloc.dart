import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'artist_home_event.dart';
part 'artist_home_state.dart';

class ArtistHomeBloc extends Bloc<ArtistHomeEvent, ArtistHomeState> {
  ArtistHomeBloc() : super(ArtistHomeState()) {
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
  }
}
