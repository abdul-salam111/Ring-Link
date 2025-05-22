
import 'package:ring_link/services/storage.dart';

class SessionController {
  final LocalStorage localStorage = LocalStorage();
  // GetUserDetails getUserDetails = GetUserDetails();
  static final SessionController _session = SessionController._internal();
  bool islogin = false;
  SessionController._internal();

  static SessionController get instance => _session;

  factory SessionController() {
    return _session;
  }

  // Future<void> saveUserInStorage(GetUserDetails user) async {
  //   await localStorage.setValues(token, jsonEncode(user));
  //   await localStorage.setValues(loggedin, 'true');
  // }

  // Future<void> getUserfromSharedpref() async {
  //   try {
  //     final userData = await localStorage.readValues(token);
  //     final isLoggedIn = await localStorage.readValues(loggedin);

  //     if (userData != null) {
  //       SessionController().getUserDetails =
  //           GetUserDetails.fromJson(jsonDecode(userData));
  //     }
  //     SessionController().islogin = (isLoggedIn == 'true' ? true : false);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
