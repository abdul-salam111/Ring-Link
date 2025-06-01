part of 'trainer_profile_bloc.dart';

abstract class TrainerProfileEvent extends Equatable {
  const TrainerProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeTrainerProfileTab extends TrainerProfileEvent {
  final int currentTabIndex;

  const ChangeTrainerProfileTab({required this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}