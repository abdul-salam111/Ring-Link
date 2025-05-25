part of 'trainer_profile_artist_bloc.dart';

class TrainerProfileArtistState extends Equatable {
  final int currentTabIndex;
  const TrainerProfileArtistState({
    this.currentTabIndex = 0,
  });

  TrainerProfileArtistState copyWith({int? currentTabIndex}) {
    return TrainerProfileArtistState(
        currentTabIndex: currentTabIndex ?? this.currentTabIndex);
  }

  @override
  List<Object> get props => [currentTabIndex];
}
