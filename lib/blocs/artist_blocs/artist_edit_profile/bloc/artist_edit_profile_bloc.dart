import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/repositories/artist_repositories/artist_profile_repo/artist_profile_repo.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/enums.dart';

part 'artist_edit_profile_event.dart';
part 'artist_edit_profile_state.dart';

class ArtistEditProfileBloc
    extends Bloc<ArtistEditProfileEvent, ArtistEditProfileState> {
  ArtistProfileRepository artistProfileRepository;
  ArtistEditProfileBloc(this.artistProfileRepository)
      : super(const ArtistEditProfileState()) {
    on<SelectExperienceLevel>((event, emit) {
      emit(state.copyWith(
          selectedExperienceLevel: event.selectedExperienceLevel));
    });

    on<UpdateArtistName>((event, emit) {
      emit(state.copyWith(artistName: event.artistName));
    });

    on<UpdateArtistBio>((event, emit) {
      emit(state.copyWith(artistBio: event.artistBio));
    });

    on<UpdateArtistTrainingGoal>((event, emit) {
      emit(state.copyWith(artistTrainingGoal: event.artistTrainingGoal));
    });

    on<UpdateArtistProfilePicture>((event, emit) {
      emit(state.copyWith(artistProfilePicture: event.artistProfilePicture));
    });

    on<UpdateArtistTagline>((event, emit) {
      emit(state.copyWith(artistTagline: event.artistTagline));
    });

    on<UpdateArtistLocationGeoPoint>((event, emit) {
      emit(
          state.copyWith(artistLocationGeoPoint: event.artistLocationGeoPoint));
    });

    on<UpdateArtistAddress>((event, emit) {
      emit(state.copyWith(artistAddress: event.artistAddress));
    });

    on<UpdatePreferredSessionTypes>((event, emit) {
      final currentList = state.artistPreferredSessionType;

      if (!currentList.contains(event.preferredSessionTypes)) {
        emit(state.copyWith(
          artistPreferredSessionType: [
            ...currentList,
            event.preferredSessionTypes,
          ],
        ));
      }
    });

    on<RemoveFromPrefferedSessionTypeEvent>((event, emit) {
      final updatedList = state.artistPreferredSessionType
          .where((type) => type != event.preferredSessionTypes)
          .toList();

      emit(state.copyWith(
        artistPreferredSessionType: updatedList,
      ));
    });

    on<UpdateTrainingHistory>((event, emit) {
      emit(state.copyWith(artistTrainingHistory: event.trainingHistory));
    });

    on<LoadMyProfileDataEvent>(loadMyProfileData);
    on<UpdateArtistProfile>(updateArtistProfile);
  }

  void loadMyProfileData(
      LoadMyProfileDataEvent event, Emitter<ArtistEditProfileState> emit) {
    emit(state.copyWith(
      artistAddress: SessionController().getArtistDetails.artistAddress,
      artistBio: SessionController().getArtistDetails.artistBio,
      artistLocationGeoPoint:
          SessionController().getArtistDetails.artistLocation,
      artistName: SessionController().getArtistDetails.artistName,
      artistPreferredSessionType:
          SessionController().getArtistDetails.artistPreferredTrainingStyle,
      artistProfilePicture:
          SessionController().getArtistDetails.artistProfileImage,
      artistTagline: SessionController().getArtistDetails.artistTagline,
      artistTrainingGoal:
          SessionController().getArtistDetails.artistTrainingGoal,
      artistTrainingHistory:
          SessionController().getArtistDetails.trainingHistory,
      selectedExperienceLevel: SessionController().getArtistDetails.artistLevel,
    ));
  }

  Future updateArtistProfile(
      UpdateArtistProfile event, Emitter<ArtistEditProfileState> emit) async {
    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));

      await artistProfileRepository.updateArtistProfile(
        profileImage: File(state.artistProfilePicture),
        userName: state.artistName,
        artistBio: state.artistBio,
        tagline: state.artistTagline,
        trainingGoal: state.artistTrainingGoal,
        prefferedSession: state.artistPreferredSessionType,
        experience: state.selectedExperienceLevel,
      );
      
      emit(state.copyWith(apiStatus: ApiStatus.success));
    } catch (e) {
      emit(state.copyWith(apiStatus: ApiStatus.error, message: e.toString()));
    }
  }
}
