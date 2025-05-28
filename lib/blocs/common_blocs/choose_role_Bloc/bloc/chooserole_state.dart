part of 'chooserole_bloc.dart';

class ChooseroleState extends Equatable {
  final UserType chooseRole;

  const ChooseroleState(
      {this.chooseRole = UserType.artist,
     });

  ChooseroleState copyWith(
      {UserType? chooseRole, String? message, ApiStatus? apiStatus}) {
    return ChooseroleState(
      chooseRole: chooseRole ?? this.chooseRole,
 
    );
  }

  @override
  List<Object> get props => [chooseRole, ];
}
