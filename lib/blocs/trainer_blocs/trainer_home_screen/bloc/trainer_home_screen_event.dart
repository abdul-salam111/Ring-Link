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