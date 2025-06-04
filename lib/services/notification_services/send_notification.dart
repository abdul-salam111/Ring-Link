import 'dart:convert';

import 'package:ring_link/services/notification_services/get_server_key.dart';
import 'package:http/http.dart' as http;

class SendPushNotification {
  static sendNotification(
      {required String deviceToken, required String title,required String body, dynamic data}) async {
    final String serverKey = await GetServerKey().getServerToken();
    String firebaseMessagingApi =
        "https://fcm.googleapis.com/v1/projects/ringlink-v1-mvp/messages:send";

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data,
      }
    };
    final http.Response response =
        await http.post(Uri.parse(firebaseMessagingApi),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $serverKey',
            },
            body: jsonEncode(message));
    if (response.statusCode == 200) {
      print("notifiations send successfully");
    }
  }
}
