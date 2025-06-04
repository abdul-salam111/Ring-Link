import 'dart:convert';

CreateTrainerModel createTrainerModelFromJson(String str) =>
    CreateTrainerModel.fromJson(json.decode(str));

String createTrainerModelToJson(CreateTrainerModel data) =>
    json.encode(data.toJson());

class CreateTrainerModel {
  String? trainerUsername;
  String? trainerEmail;
  String? trainerRating;
  String? trainerPrice;
  String? trainerExpereince;
  TrainerLocation? trainerLocation;
  String? trainerBio;
  String? trainerTagline;
  List<String>? trainerAvailableSlots;
  List<TrainerReview>? trainerReviews;
  List<String>? trainerSessionType;
  String? trainerId;
  String? trainerProfilePicture;
  String? userType;
  DateTime? createdAt;
  String? trainerAddress;
  String? trainer_device_token;

  CreateTrainerModel(
      {this.trainerUsername,
      this.trainerEmail,
      this.trainerRating,
      this.trainerPrice,
      this.trainerExpereince,
      this.trainerLocation,
      this.trainerBio,
      this.trainerTagline,
      this.trainerAvailableSlots,
      this.trainerReviews,
      this.trainerSessionType,
      this.trainerId,
      this.trainerProfilePicture,
      this.userType,
      this.createdAt,
      this.trainer_device_token,
      this.trainerAddress});

  factory CreateTrainerModel.fromJson(Map<String, dynamic> json) =>
      CreateTrainerModel(
          trainerUsername: json["trainer_username"],
          trainerEmail: json["trainer_email"],
          trainerRating: json["trainer_rating"],
          trainerPrice: json["trainer_price"],
          trainerExpereince: json["trainer_expereince"],
          trainerLocation: json["trainer_location"] == null
              ? null
              : TrainerLocation.fromJson(json["trainer_location"]),
          trainerBio: json["trainer_bio"],
          trainerTagline: json["trainer_tagline"],
          trainerAvailableSlots: json["trainer_available_slots"] == null
              ? []
              : List<String>.from(
                  json["trainer_available_slots"].map((x) => x)),
          trainerReviews: json["trainer_reviews"] == null
              ? []
              : List<TrainerReview>.from(json["trainer_reviews"]
                  .map((x) => TrainerReview.fromJson(x))),
          trainerSessionType: json["trainer_sessionType"] == null
              ? []
              : List<String>.from(json["trainer_sessionType"].map((x) => x)),
          trainerId: json["trainer_id"],
          trainerProfilePicture: json["trainer_profile_picture"],
          userType: json["userType"],
          trainer_device_token:json['trainer_device_token'],
          createdAt: json["createdAt"] == null
              ? null
              : DateTime.parse(json["createdAt"]),
          trainerAddress: json['trainer_address']);

  Map<String, dynamic> toJson() => {
        "trainer_username": trainerUsername,
        "trainer_email": trainerEmail,
        "trainer_rating": trainerRating,
        "trainer_price": trainerPrice,
        "trainer_expereince": trainerExpereince,
        "trainer_location": trainerLocation?.toJson(),
        "trainer_bio": trainerBio,
        "trainer_tagline": trainerTagline,
        "trainer_available_slots": trainerAvailableSlots ?? [],
        "trainer_reviews":
            trainerReviews?.map((x) => x.toJson()).toList() ?? [],
        "trainer_sessionType": trainerSessionType ?? [],
        "trainer_id": trainerId,
        "trainer_profile_picture": trainerProfilePicture,
        "userType": userType,
        "createdAt": createdAt?.toIso8601String(),
        "trainer_address": trainerAddress,
        "trainer_device_token":trainer_device_token,
      };
}

class TrainerReview {
  String? reviewerId;
  String? reviewText;
  int? rating;
  DateTime? createdAt;

  TrainerReview({
    this.reviewerId,
    this.reviewText,
    this.rating,
    this.createdAt,
  });

  factory TrainerReview.fromJson(Map<String, dynamic> json) => TrainerReview(
        reviewerId: json["reviewer_id"],
        reviewText: json["review_text"],
        rating: json["rating"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "reviewer_id": reviewerId,
        "review_text": reviewText,
        "rating": rating,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class TrainerLocation {
  double? latitude;
  double? longitude;

  TrainerLocation({
    this.latitude,
    this.longitude,
  });

  factory TrainerLocation.fromJson(Map<String, dynamic> json) =>
      TrainerLocation(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
