import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// Helper functions for JSON conversion
GetTrainerDetailsModel getTrainerModelFromJson(String str) => 
    GetTrainerDetailsModel.fromJson(json.decode(str));

String getTrainerModelToJson(GetTrainerDetailsModel data) => 
    json.encode(data.toJson());

class GetTrainerDetailsModel {
  String? trainerUsername;
  String? trainerEmail;
  String? trainerRating;
  String? trainerPrice;
  String? trainerExpereince;
  GeoPoint? trainerLocation;
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

  

  GetTrainerDetailsModel({
    this.trainerUsername,
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
    this.trainerAddress
  });

  factory GetTrainerDetailsModel.fromJson(Map<String, dynamic> json) {
    // Handle GeoPoint conversion
    GeoPoint? parseGeoPoint(dynamic location) {
      if (location == null) return null;
      if (location is GeoPoint) return location;
      if (location is Map) {
        return GeoPoint(
          location['latitude'] as double,
          location['longitude'] as double,
        );
      }
      return null;
    }

    // Handle DateTime conversion
    DateTime? parseDateTime(dynamic date) {
      if (date == null) return null;
      if (date is Timestamp) return date.toDate();
      if (date is String) return DateTime.tryParse(date);
      return null;
    }

    return GetTrainerDetailsModel(
      trainerUsername: json["trainer_username"],
      trainerEmail: json["trainer_email"],
      trainerRating: json["trainer_rating"],
      trainerPrice: json["trainer_price"],
      trainerExpereince: json["trainer_expereince"],
      trainerLocation: parseGeoPoint(json["trainer_location"]),
      trainerBio: json["trainer_bio"],
      trainerTagline: json["trainer_tagline"],
      trainerAvailableSlots: json["trainer_available_slots"] == null
          ? []
          : List<String>.from(json["trainer_available_slots"].map((x) => x.toString())),
      trainerReviews: json["trainer_reviews"] == null
          ? []
          : List<TrainerReview>.from(
              json["trainer_reviews"].map((x) => TrainerReview.fromJson(x))),
      trainerSessionType: json["trainer_sessionType"] == null
          ? []
          : List<String>.from(json["trainer_sessionType"].map((x) => x.toString())),
      trainerId: json["trainer_id"],
      trainerProfilePicture: json["trainer_profile_picture"],
      userType: json["userType"],
      createdAt: parseDateTime(json["createdAt"]),
      trainerAddress: json['trainer_address']
    );
  }

  Map<String, dynamic> toJson() {
    // Convert GeoPoint to serializable format
    dynamic serializeGeoPoint(GeoPoint? point) {
      if (point == null) return null;
      return {
        'latitude': point.latitude,
        'longitude': point.longitude,
      };
    }

    return {
      "trainer_username": trainerUsername,
      "trainer_email": trainerEmail,
      "trainer_rating": trainerRating,
      "trainer_price": trainerPrice,
      "trainer_expereince": trainerExpereince,
      "trainer_location": serializeGeoPoint(trainerLocation),
      "trainer_bio": trainerBio,
      "trainer_tagline": trainerTagline,
      "trainer_available_slots": trainerAvailableSlots ?? [],
      "trainer_reviews": trainerReviews?.map((x) => x.toJson()).toList() ?? [],
      "trainer_sessionType": trainerSessionType ?? [],
      "trainer_id": trainerId,
      "trainer_profile_picture": trainerProfilePicture,
      "userType": userType,
      "createdAt": createdAt?.toIso8601String(),
      "trainer_address":trainerAddress,
    };
  }
}

class TrainerReview {
  String? reviewerId;
  String? reviewText;
  String? rating;
  DateTime? createdAt;

  TrainerReview({
    this.reviewerId,
    this.reviewText,
    this.rating,
    this.createdAt,
  });

  factory TrainerReview.fromJson(Map<String, dynamic> json) {
    DateTime? parseDateTime(dynamic date) {
      if (date == null) return null;
      if (date is Timestamp) return date.toDate();
      if (date is String) return DateTime.tryParse(date);
      return null;
    }

    return TrainerReview(
      reviewerId: json["reviewer_id"],
      reviewText: json["review_text"],
      rating: json["rating"],
      createdAt: parseDateTime(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "reviewer_id": reviewerId,
    "review_text": reviewText,
    "rating": rating,
    "createdAt": createdAt?.toIso8601String(),
  };
}