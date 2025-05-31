import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingHistory {
  final String? trainingTitle;
  final DateTime? trainingDate;
  final String? trainingType;

  TrainingHistory({
    this.trainingTitle,
    this.trainingDate,
    this.trainingType,
  });

  factory TrainingHistory.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic date) {
      if (date == null) return null;
      if (date is Timestamp) return date.toDate();
      if (date is String) return DateTime.tryParse(date);
      return null;
    }

    return TrainingHistory(
      trainingTitle: json['training_title'],
      trainingDate: parseDate(json['training_date']),
      trainingType: json['training_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'training_title': trainingTitle,
      'training_date': trainingDate?.toIso8601String(),
      'training_type': trainingType,
    };
  }
}

class GetArtistDetails {
  final String? artistName;
  final String? artistEmail;
  final DateTime? createdAt;
  String? artistUserId;
  final String? userType;
  final String? artistTagline;
  final String? artistBio;
  final String? artistProfileImage;
  final String? artistLevel;
  final GeoPoint? artistLocation;
  final String? artistTrainingGoal;
  final List<String>? artistPreferredTrainingStyle;
  final List<TrainingHistory>? trainingHistory;

  GetArtistDetails({
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
    this.artistPreferredTrainingStyle,
    this.trainingHistory,
  });

  factory GetArtistDetails.fromJson(Map<String, dynamic> json) {
    GeoPoint? parseGeoPoint(dynamic location) {
      if (location == null) return null;
      if (location is GeoPoint) return location;
      if (location is Map) {
        return GeoPoint(
          (location['latitude'] as num).toDouble(),
          (location['longitude'] as num).toDouble(),
        );
      }
      return null;
    }

    DateTime? parseDateTime(dynamic date) {
      if (date == null) return null;
      if (date is Timestamp) return date.toDate();
      if (date is String) return DateTime.tryParse(date);
      return null;
    }

    return GetArtistDetails(
      artistName: json["artist_name"],
      artistEmail: json["artist_email"],
      createdAt: parseDateTime(json["created_at"]),
      artistUserId: json["artist_user_id"],
      userType: json["user_type"],
      artistTagline: json["artist_tagline"],
      artistBio: json["artist_bio"],
      artistProfileImage: json["artist_profile_image"],
      artistLevel: json["artist_level"],
      artistLocation: parseGeoPoint(json["artist_location"]),
      artistTrainingGoal: json["artist_training_goal"],
      artistPreferredTrainingStyle: json["artist_preferred_training_style"] != null
          ? List<String>.from(json["artist_preferred_training_style"].map((x) => x.toString()))
          : null,
      trainingHistory: json["training_history"] != null
          ? List<TrainingHistory>.from(json["training_history"].map((x) => TrainingHistory.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    dynamic serializeGeoPoint(GeoPoint? point) {
      if (point == null) return null;
      return {
        'latitude': point.latitude,
        'longitude': point.longitude,
      };
    }

    return {
      "artist_name": artistName,
      "artist_email": artistEmail,
      "created_at": createdAt?.toIso8601String(),
      "artist_user_id": artistUserId,
      "user_type": userType,
      "artist_tagline": artistTagline,
      "artist_bio": artistBio,
      "artist_profile_image": artistProfileImage,
      "artist_level": artistLevel,
      "artist_location": serializeGeoPoint(artistLocation),
      "artist_training_goal": artistTrainingGoal,
      "artist_preferred_training_style": artistPreferredTrainingStyle,
      "training_history": trainingHistory?.map((x) => x.toJson()).toList(),
    };
  }
}
