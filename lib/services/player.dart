import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Player {

  void play() async{
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("authenticationToken");
    print("THIS IS TOKEN:      " + token);

    final response = await http.put(Uri.parse("https://api.spotify.com/v1/me/player/play"),
        headers: {
          "Authorization": "Bearer " + token.toString(),
        }
    );
    print(response.body);
  }

  void pause() async{
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("authenticationToken");
    print("THIS IS TOKEN:      " + token);
    final response = await http.put(Uri.parse("https://api.spotify.com/v1/me/player/pause"),
        headers: {
          "Authorization": "Bearer " + token,
        }
    );
    print(response.statusCode);
    print(response.body);
  }

  void skipToNextTrack() async{
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("authenticationToken");
    print("THIS IS TOKEN:      " + token);

    final response = await http.post(Uri.parse("https://api.spotify.com/v1/me/player/next"),
        headers: {
          "Authorization": "Bearer " + token,
        }
    );
    print(response.statusCode);
    print(response.body);
  }

  void skipToPreviousTrack() async{
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("authenticationToken");
    print("THIS IS TOKEN:      " + token);

    final response = await http.post(Uri.parse("https://api.spotify.com/v1/me/player/previous"),
        headers: {
          "Authorization": "Bearer " + token,
        }
    );
    print(response.statusCode);
  }

  void repeat(String state) async{
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("authenticationToken");
    print("THIS IS TOKEN:      " + token);

    final response = await http.put(Uri.parse("https://api.spotify.com/v1/me/player/repeat?state=$state"),
        headers: {
          "Authorization": "Bearer " + token,
        },
    );

    print(response.statusCode);
    print(response.body);
  }

  void shuffle(bool state) async{
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("authenticationToken");
    print("THIS IS TOKEN:      " + token);

    final response = await http.put(Uri.parse("https://api.spotify.com/v1/me/player/shuffle?state=${state.toString()}"),
        headers: {
          "Authorization": "Bearer " + token,
        }
    );
    print(response.statusCode);
    print(response.body);
  }

}