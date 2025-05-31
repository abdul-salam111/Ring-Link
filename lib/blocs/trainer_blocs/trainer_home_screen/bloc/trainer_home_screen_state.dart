part of 'trainer_home_screen_bloc.dart';

class TrainerHomeScreenState extends Equatable {
  final int currentTabIndex;
  final String message;
  final ApiStatus apiStatus;
  final List<GetArtistDetails> allArtistData;
  final List<GetArtistDetails> allArtistsDataForFilteration;

  const TrainerHomeScreenState({
    this.currentTabIndex = 0,
    this.message = '',
    this.apiStatus = ApiStatus.initial,
    this.allArtistData = const [],
    this.allArtistsDataForFilteration = const [],
  });

  TrainerHomeScreenState copyWith({
    int? currentTabIndex,
    String? message,
    ApiStatus? apiStatus,
    List<GetArtistDetails>? allArtistData,
    List<GetArtistDetails>? allArtistsDataForFilteration,
  }) {
    return TrainerHomeScreenState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      message: message ?? this.message,
      apiStatus: apiStatus ?? this.apiStatus,
      allArtistData: allArtistData ?? this.allArtistData,
      allArtistsDataForFilteration:
          allArtistsDataForFilteration ?? this.allArtistsDataForFilteration,
    );
  }

  @override
  List<Object> get props => [
        currentTabIndex,
        message,
        apiStatus,
        allArtistData,
        allArtistsDataForFilteration,
      ];
}
