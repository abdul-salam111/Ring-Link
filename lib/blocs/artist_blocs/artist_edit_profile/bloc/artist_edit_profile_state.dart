part of 'artist_edit_profile_bloc.dart';

class ArtistEditProfileState extends Equatable {
  final String selectedExperienceLevel;
  final String artistName;
  final String artistBio;
  final String artistTrainingGoal;
  final String artistProfilePicture;
  final String artistTagline;
  final GeoPoint artistLocationGeoPoint;
  final String artistAddress;
  final List<String> artistPreferredSessionType;
  final List<TrainingHistory> artistTrainingHistory;
  final ApiStatus apiStatus;
  final String message;

  const ArtistEditProfileState({
    this.selectedExperienceLevel = "",
    this.artistName = "",
    this.artistBio = "",
    this.artistTrainingGoal = "",
    this.artistProfilePicture = "",
    this.artistTagline = "",
    this.artistLocationGeoPoint = const GeoPoint(0, 0),
    this.artistAddress = "",
    this.artistPreferredSessionType = const [],
    this.artistTrainingHistory = const [],
    this.apiStatus = ApiStatus.initial,
    this.message = "",
  });

  ArtistEditProfileState copyWith({
    String? selectedExperienceLevel,
    String? artistName,
    String? artistBio,
    String? artistTrainingGoal,
    String? artistProfilePicture,
    String? artistTagline,
    GeoPoint? artistLocationGeoPoint,
    String? artistAddress,
    List<String>? artistPreferredSessionType,
    List<TrainingHistory>? artistTrainingHistory,
    String? message,
    ApiStatus? apiStatus,
  }) {
    return ArtistEditProfileState(
        selectedExperienceLevel:
            selectedExperienceLevel ?? this.selectedExperienceLevel,
        artistName: artistName ?? this.artistName,
        artistBio: artistBio ?? this.artistBio,
        artistTrainingGoal: artistTrainingGoal ?? this.artistTrainingGoal,
        artistProfilePicture: artistProfilePicture ?? this.artistProfilePicture,
        artistTagline: artistTagline ?? this.artistTagline,
        artistLocationGeoPoint:
            artistLocationGeoPoint ?? this.artistLocationGeoPoint,
        artistAddress: artistAddress ?? this.artistAddress,
        artistPreferredSessionType:
            artistPreferredSessionType ?? this.artistPreferredSessionType,
        artistTrainingHistory:
            artistTrainingHistory ?? this.artistTrainingHistory,
        message: message ?? this.message,
        apiStatus: apiStatus ?? this.apiStatus);
  }

  @override
  List<Object> get props => [
        selectedExperienceLevel,
        artistName,
        artistBio,
        artistTrainingGoal,
        artistProfilePicture,
        artistTagline,
        artistLocationGeoPoint,
        artistAddress,
        artistPreferredSessionType,
        artistTrainingHistory,
        apiStatus,
        message,
      ];
}
