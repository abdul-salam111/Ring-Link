part of 'artist_home_bloc.dart';

class ArtistHomeEvent extends Equatable {
  const ArtistHomeEvent();

  @override
  List<Object> get props => [];
}

class ArtistHomeTabChanged extends ArtistHomeEvent {
  final int currentTabIndex;

  const ArtistHomeTabChanged({required this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}

class SelectLocation extends ArtistHomeEvent {
  final String location;
  const SelectLocation(this.location);
  @override
  List<Object> get props => [location];
}

class SelectLevel extends ArtistHomeEvent {
  final String selectedLevel;
  const SelectLevel(this.selectedLevel);
  @override
  List<Object> get props => [selectedLevel];
}

class SelectPriceRange extends ArtistHomeEvent {
  final RangeValues selectedRange;
  const SelectPriceRange(this.selectedRange);
  @override
  List<Object> get props => [selectedRange];
}

class SelectMinimumRating extends ArtistHomeEvent {
  final double minimumRating;
  const SelectMinimumRating(this.minimumRating);
  @override
  List<Object> get props => [minimumRating];
}

class SelectAvailability extends ArtistHomeEvent {
  final String availability;
  const SelectAvailability(this.availability);
  @override
  List<Object> get props => [availability];
}

class SelectSessionType extends ArtistHomeEvent {
  final String sessionType;
  const SelectSessionType(this.sessionType);
  @override
  List<Object> get props => [sessionType];
}

class SelectVirtualTraining extends ArtistHomeEvent {
  final bool virtualTraining;
  const SelectVirtualTraining(this.virtualTraining);
  @override
  List<Object> get props => [virtualTraining];
}

class ResetFilters extends ArtistHomeEvent {
  const ResetFilters();

  @override
  List<Object> get props => [];
}

class ApplyFilters extends ArtistHomeEvent {
  const ApplyFilters();

  @override
  List<Object> get props => [];
}

class FetchAllTrainerEvent extends ArtistHomeEvent {}

class SearchTrainerEvent extends ArtistHomeEvent {
  final String searchQuery;

  const SearchTrainerEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}
