part of 'chooserole_bloc.dart';

abstract class ChooseroleEvent extends Equatable {
  const ChooseroleEvent();

  @override
  List<Object> get props => [];
}

class ChooseRoleChanged extends ChooseroleEvent {
  final UserType chooseRole;

  const ChooseRoleChanged({required this.chooseRole});

  @override
  List<Object> get props => [chooseRole];
}

