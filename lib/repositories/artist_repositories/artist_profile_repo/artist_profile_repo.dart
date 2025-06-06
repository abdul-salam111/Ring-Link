import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/app_urls.dart';
import 'package:ring_link/utils/collections.dart';
import 'package:ring_link/utils/uploadImages.dart';

class ArtistProfileRepository {
  Future<bool> updateArtistProfile({
    File? profileImage,
    String? userName,
    String? artistBio,
    String? tagline,
    String? trainingGoal,
    List<String>? prefferedSession,
    String? experience,
  }) async {
    try {
      final docRef = firebaseFirestore
          .collection(artistCollection)
          .doc(SessionController().getArtistDetails.artistUserId);

      Map<String, dynamic> updatedData = {};

      if (profileImage != null) {
        String? profileimageurl =
            await uploadImage(profileImage, artistprofileStorage);
        if (profileimageurl != null && profileimageurl.trim().isNotEmpty) {
          updatedData['artist_profile_image'] = profileimageurl;
        }
      }

      // ✅ Only update non-null fields
      if (userName != null && userName.trim().isNotEmpty) {
        updatedData['artist_name'] = userName.trim();
      }

      if (artistBio != null && artistBio.trim().isNotEmpty) {
        updatedData['artist_bio'] = artistBio.trim();
      }

      if (tagline != null && tagline.trim().isNotEmpty) {
        updatedData['artist_tagline'] = tagline.trim();
      }

      if (trainingGoal != null && trainingGoal.trim().isNotEmpty) {
        updatedData['artist_training_goal'] = trainingGoal.trim();
      }

      if (prefferedSession != null && prefferedSession.isNotEmpty) {
        updatedData['artist_preferred_training_style'] = prefferedSession;
      }

      if (experience != null && experience.trim().isNotEmpty) {
        updatedData['artist_level'] = experience.trim();
      }

      if (updatedData.isNotEmpty) {
        await docRef.update(updatedData);
      }
      DocumentSnapshot snapshot = await docRef.get();

      GetArtistDetails getArtistModel =
          GetArtistDetails.fromJson(snapshot.data() as Map<String, dynamic>);

      await SessionController().saveUserInStorage(getArtistModel);
      await SessionController().getUserfromSharedpref();
      

      return true;
    } catch (e) {
      return false;
    }
  }
}
