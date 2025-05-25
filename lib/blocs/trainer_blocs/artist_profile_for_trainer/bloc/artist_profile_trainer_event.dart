part of 'artist_profile_trainer_bloc.dart';

abstract class ArtistProfileTrainerEvent extends Equatable {
  const ArtistProfileTrainerEvent();

  @override
  List<Object> get props => [];
}

class ArtistProfileTabChanged extends ArtistProfileTrainerEvent {
  final int currentTabIndex;

  const ArtistProfileTabChanged({required this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}