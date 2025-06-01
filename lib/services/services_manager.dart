import 'dart:convert';

import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/models/trainers/get_models/get_trainer_details_model.dart';
import 'package:ring_link/services/storage.dart';

class SessionController {
  GetArtistDetails getArtistDetails = GetArtistDetails();
  GetTrainerDetailsModel getTrainerDetailsModel = GetTrainerDetailsModel();
  static final SessionController _session = SessionController._internal();
  bool islogin = false;
  
  SessionController._internal();

  static SessionController get instance => _session;

  factory SessionController() {
    return _session;
  }

  Future<void> saveUserInStorage(
    dynamic user,
  ) async {
    final String usertype = await storage.readValues(
      StorageKeys.userType,
    );
    if (usertype == UserType.artist.name) {
      await storage.setValues(StorageKeys.artistDetails, jsonEncode(user));
      await storage.setValues(StorageKeys.userType, UserType.artist.name);
    } else {
      await storage.setValues(StorageKeys.trainerDetails, jsonEncode(user));
      await storage.setValues(StorageKeys.userType, UserType.trainer.name);
    }
    await storage.setValues(StorageKeys.loggedIn, 'true');
  }

  Future<void> getUserfromSharedpref() async {
    try {
      final userType =await storage.readValues(StorageKeys.userType);
      if (userType == UserType.artist.name) {
        final userData = await storage.readValues(StorageKeys.artistDetails);
        if (userData != null) {
          SessionController().getArtistDetails =
              GetArtistDetails.fromJson(jsonDecode(userData));
        }
      } else {
        final userData = await storage.readValues(StorageKeys.trainerDetails);
        if (userData != null) {
          SessionController().getTrainerDetailsModel =
              GetTrainerDetailsModel.fromJson(jsonDecode(userData));
        }
      }
      final isLoggedIn = await storage.readValues(StorageKeys.loggedIn);

      SessionController().islogin = (isLoggedIn == 'true' ? true : false);
    } catch (e) {
      print(e);
    }
  }
}
