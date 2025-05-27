import 'dart:convert';

import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/services/storage.dart';

class SessionController {
  GetArtistDetails getArtistDetails = GetArtistDetails();
  static final SessionController _session = SessionController._internal();
  bool islogin = false;
  SessionController._internal();

  static SessionController get instance => _session;

  factory SessionController() {
    return _session;
  }

  Future<void> saveUserInStorage(GetArtistDetails user) async {
    await storage.setValues(StorageKeys.artistDetails, jsonEncode(user));

    await storage.setValues(StorageKeys.loggedIn, 'true');
  }

  Future<void> getUserfromSharedpref() async {
    try {
      final userData = await storage.readValues(StorageKeys.artistDetails);
      final isLoggedIn = await storage.readValues(StorageKeys.loggedIn);

      if (userData != null) {
        SessionController().getArtistDetails =
            GetArtistDetails.fromJson(jsonDecode(userData));
      }
      SessionController().islogin = (isLoggedIn == 'true' ? true : false);
    } catch (e) {
      print(e);
    }
  }
}
