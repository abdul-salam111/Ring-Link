part of 'trainer_home_screen_bloc.dart';

class TrainerHomeScreenState extends Equatable {
  final int currentTabIndex;

  const TrainerHomeScreenState({this.currentTabIndex = 0});

  TrainerHomeScreenState copyWith({
    int? currentTabIndex,
  }) {
    return TrainerHomeScreenState(
        currentTabIndex: currentTabIndex ?? this.currentTabIndex);
  }

  @override
  List<Object> get props => [currentTabIndex];
}
