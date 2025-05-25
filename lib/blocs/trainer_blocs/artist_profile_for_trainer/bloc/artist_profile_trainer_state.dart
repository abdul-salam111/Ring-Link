part of 'artist_profile_trainer_bloc.dart';

class ArtistProfileTrainerState extends Equatable {
  final int currentTabIndex;
  const ArtistProfileTrainerState({this.currentTabIndex = 0});
  ArtistProfileTrainerState copyWith({
    int? currentTabIndex,
  }) {
    return ArtistProfileTrainerState(
        currentTabIndex: currentTabIndex ?? this.currentTabIndex);
  }

  @override
  List<Object> get props => [currentTabIndex];
}

final class ArtistProfileTrainerInitial extends ArtistProfileTrainerState {}
