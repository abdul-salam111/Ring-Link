import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ring_link/config/exceptions/app_exceptions.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/models/artists/post_models/create_artist_model.dart';
import 'package:ring_link/utils/collections.dart';
import 'package:ring_link/utils/library.dart';
import '../../../services/storage.dart';

class ArtistAuthRepository {
  //register artist
  Future<bool> signUpArtistWithEmailAndPassword(
      CreateArtistModel createArtistModel) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: createArtistModel.artistEmail!,
        password: createArtistModel.artistPassword!,
      );
      await storage.setValues(
          StorageKeys.artistDetails, jsonEncode(createArtistModel.toJson()));
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

//login artist
  Future<GetArtistDetails> signInArtistWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user != null && user.emailVerified) {
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
            return createArtistModel;
          }
        }

        return createArtistModel;
      } else if (user != null && !user.emailVerified) {
        await firebaseAuth.signOut();
        throw NotFoundException("Please verify your email address.");
      }

      throw Exception('User not found. Please try again.');
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('Sign-in failed. Please try again.');
    }
  }

  //update user role
  Future<bool> updateUserRole(String role) async {
    try {
      final userId = await storage.readValues(StorageKeys.userId);
      await firebaseFirestore
          .collection(artistCollection)
          .doc(userId)
          .update({'user_type': role});
      return true;
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }

  Exception handleFirebaseAuthException(FirebaseAuthException e) {
    print(e.code);
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
