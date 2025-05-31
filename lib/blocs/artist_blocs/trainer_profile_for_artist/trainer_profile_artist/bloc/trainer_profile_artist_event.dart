part of 'trainer_profile_artist_bloc.dart';

abstract class TrainerProfileArtistEvent extends Equatable {
  const TrainerProfileArtistEvent();

  @override
  List<Object> get props => [];
}

class ChangeTrainerProfileTab extends TrainerProfileArtistEvent {
  final int currentTabIndex;

  const ChangeTrainerProfileTab({required this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}


