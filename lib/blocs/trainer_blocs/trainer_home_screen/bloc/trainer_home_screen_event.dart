part of 'trainer_home_screen_bloc.dart';

abstract class TrainerHomeScreenEvent extends Equatable {
  const TrainerHomeScreenEvent();

  @override
  List<Object> get props => [];
}

class ArtistHomeTabChanged extends TrainerHomeScreenEvent {
  final int currentTabIndex;

  const ArtistHomeTabChanged({required this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}
class FetchAllArtistEvent extends TrainerHomeScreenEvent {}
// Add this to your trainer_home_screen_event.dart
class SearchArtistEvent extends TrainerHomeScreenEvent {
  final String searchQuery;

  const SearchArtistEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}