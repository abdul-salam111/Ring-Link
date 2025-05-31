import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ring_link/config/exceptions/app_exceptions.dart';
import 'package:ring_link/utils/app_urls.dart';
import 'package:ring_link/utils/collections.dart';

import '../../../models/trainers/get_models/get_trainer_details_model.dart';

class ArtistHomeScreenRepository {
  Future<List<GetTrainerDetailsModel>> fetchAllTrainers() async {
    try {
      final QuerySnapshot snapshot =
          await firebaseFirestore.collection(trainerCollection).get();

      List<GetTrainerDetailsModel> trainers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return GetTrainerDetailsModel.fromJson(data);
      }).toList();

      return trainers;
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
      return [];
    }
  }

  Exception handleFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'unknown':
        return NotFoundException('An unknown error occurred.');
      case 'invalid-argument':
        return InvalidInputException('Invalid input argument provided.');
      case 'deadline-exceeded':
        return TimeoutException('The operation took too long to complete.');
      case 'not-found':
        return NotFoundException('The requested document was not found.');
      case 'already-exists':
        return EmailAlreadyExist('The document already exists.');
      case 'permission-denied':
        return ForbiddenException(
            'You do not have permission to perform this action.');
      case 'resource-exhausted':
        return TooManyRequestsException(
            'Resource or quota has been exhausted.');

      case 'internal':
        return InternalServerErrorException(
            'An internal server error occurred.');
      case 'unavailable':
        return ServiceUnavailableException(
            'The service is currently unavailable. Try again later.');

      case 'unauthenticated':
        return UnauthorizedException(
            'You are not authenticated. Please log in again.');
      default:
        return Exception('Firestore error: ${e.message}');
    }
  }
}
