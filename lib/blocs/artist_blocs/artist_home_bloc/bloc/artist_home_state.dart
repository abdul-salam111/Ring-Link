part of 'artist_home_bloc.dart';

class ArtistHomeState extends Equatable {
  final int currentTabIndex;
  final String selectedLocation;
  final List<String> locations;
  final String selectedLevel;
  final RangeValues selectedRange;
  final double minimumRating;
  final String avialibility;
  final bool virtualTraining;
  final String sessionType;
  final String message;
  final ApiStatus apiStatus;

  final List<GetTrainerDetailsModel> allTrainersData;
  final List<GetTrainerDetailsModel> allTrainersDataForFilteration;

  const ArtistHomeState(
      {this.currentTabIndex = 0,
      this.selectedLocation = "",
      this.selectedLevel = "",
      this.minimumRating = 0.0,
      this.avialibility = "",
      this.sessionType = "",
      this.message = "",
      this.apiStatus = ApiStatus.initial,
      this.virtualTraining = false,
      this.selectedRange = const RangeValues(50, 150),
      this.locations = const ["USA", "UK", "Canada", "Australia"],
      this.allTrainersData = const [],
      this.allTrainersDataForFilteration = const []});

  ArtistHomeState copyWith({
    int? currentTabIndex,
    String? selectedLocation,
    List<String>? locations,
    String? selectedLevel,
    RangeValues? selectedRange,
    double? minimumRating,
    String? avialibility,
    ApiStatus? apiStatus,
    String? sessionType,
    bool? virtualTraining,
    List<GetTrainerDetailsModel>? allTrainersData,
    List<GetTrainerDetailsModel>? allTrainersDataForFilteration,
    String? message,
  }) {
    return ArtistHomeState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      locations: locations ?? this.locations,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      selectedRange: selectedRange ?? this.selectedRange,
      minimumRating: minimumRating ?? this.minimumRating,
      avialibility: avialibility ?? this.avialibility,
      sessionType: sessionType ?? this.sessionType,
      message: message ?? this.message,
      apiStatus: apiStatus ?? this.apiStatus,
      virtualTraining: virtualTraining ?? this.virtualTraining,
      allTrainersDataForFilteration:
          allTrainersDataForFilteration ?? this.allTrainersDataForFilteration,
      allTrainersData: allTrainersData ?? this.allTrainersData,
    );
  }

  @override
  List<Object> get props => [
        currentTabIndex,
        selectedLocation,
        locations,
        selectedLevel,
        selectedRange,
        minimumRating,
        avialibility,
        sessionType,
        virtualTraining,
        allTrainersData,
        allTrainersDataForFilteration,
        apiStatus,
        message,
      ];
}
