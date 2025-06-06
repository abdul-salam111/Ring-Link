part of 'artist_edit_profile_bloc.dart';

abstract class ArtistEditProfileEvent extends Equatable {
  const ArtistEditProfileEvent();

  @override
  List<Object> get props => [];
}

class SelectExperienceLevel extends ArtistEditProfileEvent {
  final String selectedExperienceLevel;
  const SelectExperienceLevel(this.selectedExperienceLevel);

  @override
  List<Object> get props => [selectedExperienceLevel];
}

class UpdateArtistName extends ArtistEditProfileEvent {
  final String artistName;
  const UpdateArtistName(this.artistName);

  @override
  List<Object> get props => [artistName];
}

class UpdateArtistBio extends ArtistEditProfileEvent {
  final String artistBio;
  const UpdateArtistBio(this.artistBio);

  @override
  List<Object> get props => [artistBio];
}

class UpdateArtistTrainingGoal extends ArtistEditProfileEvent {
  final String artistTrainingGoal;
  const UpdateArtistTrainingGoal(this.artistTrainingGoal);

  @override
  List<Object> get props => [artistTrainingGoal];
}

class UpdateArtistProfilePicture extends ArtistEditProfileEvent {
  final String artistProfilePicture;
  const UpdateArtistProfilePicture(this.artistProfilePicture);

  @override
  List<Object> get props => [artistProfilePicture];
}

class UpdateArtistTagline extends ArtistEditProfileEvent {
  final String artistTagline;
  const UpdateArtistTagline(this.artistTagline);

  @override
  List<Object> get props => [artistTagline];
}

class UpdateArtistLocationGeoPoint extends ArtistEditProfileEvent {
  final GeoPoint artistLocationGeoPoint;
  const UpdateArtistLocationGeoPoint(this.artistLocationGeoPoint);

  @override
  List<Object> get props => [artistLocationGeoPoint];
}

class UpdateArtistAddress extends ArtistEditProfileEvent {
  final String artistAddress;
  const UpdateArtistAddress(this.artistAddress);

  @override
  List<Object> get props => [artistAddress];
}

class UpdatePreferredSessionTypes extends ArtistEditProfileEvent {
  final String preferredSessionTypes;
  const UpdatePreferredSessionTypes(this.preferredSessionTypes);

  @override
  List<Object> get props => [preferredSessionTypes];
}

class UpdateTrainingHistory extends ArtistEditProfileEvent {
  final List<TrainingHistory> trainingHistory;
  const UpdateTrainingHistory(this.trainingHistory);

  @override
  List<Object> get props => [trainingHistory];
}

class RemoveFromPrefferedSessionTypeEvent extends ArtistEditProfileEvent{
  final String preferredSessionTypes;
  const RemoveFromPrefferedSessionTypeEvent(this.preferredSessionTypes);

  @override
  List<Object> get props => [preferredSessionTypes];
}

class LoadMyProfileDataEvent extends ArtistEditProfileEvent{
 const LoadMyProfileDataEvent();
}

class UpdateArtistProfile extends ArtistEditProfileEvent{
 const UpdateArtistProfile();
}