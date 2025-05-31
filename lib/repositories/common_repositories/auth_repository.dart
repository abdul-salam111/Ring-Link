import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ring_link/config/exceptions/app_exceptions.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/models/artists/post_models/create_artist_model.dart';
import 'package:ring_link/models/trainers/get_models/get_trainer_details_model.dart';
import 'package:ring_link/models/trainers/post_models/create_trainer_model.dart';
import 'package:ring_link/utils/collections.dart';
import 'package:ring_link/utils/library.dart';
import '../../services/storage.dart';

class AuthRepository {
  //register artist
  Future<bool> signUpUserWithEmailAndPassword(
      {required String userEmail,
      required String userPassword,
      CreateArtistModel? createArtist,
      CreateTrainerModel? createTrainer}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      final usertype = await storage.userType;
      if (usertype == UserType.artist.name) {
        await storage.setValues(
            StorageKeys.artistDetails, jsonEncode(createArtist!.toJson()));
      } else {
        await storage.setValues(
            StorageKeys.trainerDetails, jsonEncode(createTrainer!.toJson()));
      }

      await response.user?.sendEmailVerification();
      await firebaseAuth.signOut();
      return true;
    } on NoInternetException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('Sign-up failed. Please try again later.');
    }
  }

  Future<dynamic> signInArtistWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) throw Exception('User not found. Please try again.');

      final usertype = await storage.userType;

      // Check email verification first
      if (!user.emailVerified) {
        await firebaseAuth.signOut();
        throw NotFoundException("Please verify your email address.");
      }

      // Handle Artist
      if (usertype == UserType.artist.name) {
        final userDoc = await firebaseFirestore
            .collection(artistCollection)
            .doc(user.uid)
            .get();

        GetArtistDetails? createArtistModel = GetArtistDetails.fromJson(
          jsonDecode(
              await storage.readValues(StorageKeys.artistDetails) ?? '{}'),
        );

        await storage.setValues(StorageKeys.userId, user.uid);
        createArtistModel.artistUserId = user.uid;

        if (!userDoc.exists) {
          await firebaseFirestore
              .collection(artistCollection)
              .doc(user.uid)
              .set(createArtistModel.toJson());
        }

        final docSnapshot = await firebaseFirestore
            .collection(artistCollection)
            .doc(user.uid)
            .get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          if (data != null) {
            createArtistModel = GetArtistDetails.fromJson(data);
            await storage.setValues(
                StorageKeys.artistDetails, jsonEncode(createArtistModel));
          }
        }
        return createArtistModel;
      }
      // Handle Trainer
      else {
        final userDoc = await firebaseFirestore
            .collection(trainerCollection)
            .doc(user.uid)
            .get();

        GetTrainerDetailsModel? trainerDetailsModel =
            GetTrainerDetailsModel.fromJson(
          jsonDecode(
              await storage.readValues(StorageKeys.trainerDetails) ?? '{}'),
        );

        await storage.setValues(StorageKeys.userId, user.uid);
        trainerDetailsModel.trainerId = user.uid;

        if (!userDoc.exists) {
          await firebaseFirestore
              .collection(trainerCollection)
              .doc(user.uid)
              .set(trainerDetailsModel.toJson());
        }

        final docSnapshot = await firebaseFirestore
            .collection(trainerCollection)
            .doc(user.uid)
            .get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          if (data != null) {
            trainerDetailsModel = GetTrainerDetailsModel.fromJson(data);
            await storage.setValues(
                StorageKeys.trainerDetails, jsonEncode(trainerDetailsModel));
          }
        }
        return trainerDetailsModel;
      }
    } on FirebaseAuthException catch (e) {

      throw handleFirebaseAuthException(e);
    } catch (e) {

      throw Exception('Sign-in failed. Please try again.');
    }
  }

  Exception handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return EmailAlreadyExist('This email is already registered.');
      case 'invalid-email':
        return BadRequestException('The email address is not valid.');
      case 'weak-password':
        return Exception('The password is too weak.');
      case 'invalid-credential':
        return InvalidInputException('The provided credentials are invalid.');
      case 'network-request-failed':
        return NoInternetException(
            'No internet connection or network error occurred.');
      case 'operation-not-allowed':
        return Exception('Email/password accounts are not enabled.');
      default:
        return Exception('Authentication failed: ${e.message}');
    }
  }
}
