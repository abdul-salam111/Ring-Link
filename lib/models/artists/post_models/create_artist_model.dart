class CreateArtistModel {
  String? artistName;
  String? artistEmail;
  DateTime? createdAt;
  String? artistUserId;
  String? userType;
  String? artistTagline;
  String? artistBio;
  String? artistProfileImage;
  String? artistLevel;
  String? artistLocation;
  String? artistTrainingGoal;
  String? artistpreferredTrainingStyle;

  CreateArtistModel({
    this.artistName,
    this.artistEmail,
    this.createdAt,
    this.artistUserId,
    this.userType,
    this.artistTagline,
    this.artistBio,
    this.artistProfileImage,
    this.artistLevel,
    this.artistLocation,
    this.artistTrainingGoal,
    this.artistpreferredTrainingStyle,
  });

  factory CreateArtistModel.fromJson(Map<String, dynamic> json) =>
      CreateArtistModel(
        artistName: json["artist_name"],
        artistEmail: json["artist_email"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,

        artistUserId: json['artist_user_id'],
        userType: json['user_type'],
        artistTagline: json['artist_tagline'],
        artistBio: json['artist_bio'],
        artistProfileImage: json['artist_profile_image'],
        artistLevel: json['artist_level'],
        artistLocation: json['artist_location'],
        artistTrainingGoal: json['artist_training_goal'],
        artistpreferredTrainingStyle: json['artist_preferred_training_style'],
      );

  Map<String, dynamic> toJson() => {
        "artist_name": artistName,
        "artist_email": artistEmail,
        "created_at": createdAt?.toIso8601String(),

        "artist_user_id": artistUserId,
        "user_type": userType,
        "artist_tagline": artistTagline,
        "artist_bio": artistBio,
        "artist_profile_image": artistProfileImage,
        "artist_level": artistLevel,
        "artist_location": artistLocation,
        "artist_training_goal": artistTrainingGoal,
        "artist_preferred_training_style": artistpreferredTrainingStyle,
      };
}
