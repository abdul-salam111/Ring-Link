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

//continue with the role selection events as needed
class ChoosedRoleEvent extends ChooseroleEvent {
  final UserType role;

  const ChoosedRoleEvent({required this.role});

  @override
  List<Object> get props => [role];
}
