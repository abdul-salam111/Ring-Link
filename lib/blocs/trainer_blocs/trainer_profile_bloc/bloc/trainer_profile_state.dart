part of 'trainer_profile_bloc.dart';

class TrainerProfileState extends Equatable {
  final int currentTabIndex;
  const TrainerProfileState({this.currentTabIndex = 0});
  
  TrainerProfileState copyWith({int? currentTabIndex}) {
    return TrainerProfileState(
        currentTabIndex: currentTabIndex ?? this.currentTabIndex);
  }

  @override
  List<Object> get props => [currentTabIndex];
}
