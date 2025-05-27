part of 'chooserole_bloc.dart';

class ChooseroleState extends Equatable {
  final UserType chooseRole;
  final String message;
  final ApiStatus apiStatus;
  const ChooseroleState(
      {this.chooseRole = UserType.artist,
      this.message = '',
      this.apiStatus = ApiStatus.initial});

  ChooseroleState copyWith(
      {UserType? chooseRole, String? message, ApiStatus? apiStatus}) {
    return ChooseroleState(
      chooseRole: chooseRole ?? this.chooseRole,
      message: message ?? this.message,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object> get props => [chooseRole, message, apiStatus];
}
