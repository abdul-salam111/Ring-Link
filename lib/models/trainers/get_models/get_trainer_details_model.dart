
import 'dart:convert';

GetTrainerDetailsModel createTrainerModelFromJson(String str) => GetTrainerDetailsModel.fromJson(json.decode(str));

String createTrainerModelToJson(GetTrainerDetailsModel data) => json.encode(data.toJson());

class GetTrainerDetailsModel {
    String? trainerUsername;
    String? trainerEmail;
    String? trainerRating;
    String? trainerPrice;
    String? trainerExpereince;
    String? trainerLocation;
    String? trainerBio;
    String? trainerTagline;
    List<String>? trainerAvailableSlots;
    List<TrainerReview>? trainerReviews;
    String? trainerSessionType;
    String? trainerId;
    String? trainerProfilePicture;
    String? userType;
    DateTime? createdAt;

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
    });

    factory GetTrainerDetailsModel.fromJson(Map<String, dynamic> json) => GetTrainerDetailsModel(
        trainerUsername: json["trainer_username"],
        trainerEmail: json["trainer_email"],
        trainerRating: json["trainer_rating"],
        trainerPrice: json["trainer_price"],
        trainerExpereince: json["trainer_expereince"],
        trainerLocation: json["trainer_location"],
        trainerBio: json["trainer_bio"],
        trainerTagline: json["trainer_tagline"],
        trainerAvailableSlots: json["trainer_available_slots"] == null ? [] : List<String>.from(json["trainer_available_slots"]!.map((x) => x)),
        trainerReviews: json["trainer_reviews"] == null ? [] : List<TrainerReview>.from(json["trainer_reviews"]!.map((x) => TrainerReview.fromJson(x))),
        trainerSessionType: json["trainer_sessionType"],
        trainerId: json["trainer_id"],
        trainerProfilePicture: json["trainer_profile_picture"],
        userType: json["userType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "trainer_username": trainerUsername,
        "trainer_email": trainerEmail,
        "trainer_rating": trainerRating,
        "trainer_price": trainerPrice,
        "trainer_expereince": trainerExpereince,
        "trainer_location": trainerLocation,
        "trainer_bio": trainerBio,
        "trainer_tagline": trainerTagline,
        "trainer_available_slots": trainerAvailableSlots == null ? [] : List<dynamic>.from(trainerAvailableSlots!.map((x) => x)),
        "trainer_reviews": trainerReviews == null ? [] : List<dynamic>.from(trainerReviews!.map((x) => x.toJson())),
        "trainer_sessionType": trainerSessionType,
        "trainer_id": trainerId,
        "trainer_profile_picture": trainerProfilePicture,
        "userType": userType,
        "createdAt": createdAt?.toIso8601String(),
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
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "reviewer_id": reviewerId,
        "review_text": reviewText,
        "rating": rating,
        "createdAt": createdAt?.toIso8601String(),
    };
}
