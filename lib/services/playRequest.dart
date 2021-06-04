import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PlayRequest {
  String contextUri;
  String authToken;
  int statusCode;
  String deviceId;

  PlayRequest(String uri , String token){
    contextUri = uri;
    authToken = token;
  }

  PlayRequest.overloadedConstructor(String uri , String token , String device_id){
    contextUri = uri;
    authToken = token;
    deviceId = device_id;
  }

    void sendPlayRequest() async{
    final response = await http.put(Uri.parse("https://api.spotify.com/v1/me/player/play"),
        body: jsonEncode({
          "context_uri": contextUri,
        }),
        headers: {
          "Accept" : "application/json",
          "Authorization": "Bearer " + authToken.toString(),
        }
    );
    print(response.statusCode);
    print(response.body);

    statusCode = response.statusCode;

  }

  void senPlayRequestWithDeviceId() async {
    print("DEVICE ID: " + deviceId);
    print("https://api.spotify.com/v1/me/player/play?device_id=$deviceId");
    final response = await http.put(Uri.parse("https://api.spotify.com/v1/me/player/play?device_id=$deviceId"),
        body: jsonEncode({
          "context_uri": contextUri,
        }),
        headers: {
          "Authorization": "Bearer " + authToken.toString(),
        }
    );

    print(response.statusCode);
    print(response.body);

    statusCode = response.statusCode;

  }

}