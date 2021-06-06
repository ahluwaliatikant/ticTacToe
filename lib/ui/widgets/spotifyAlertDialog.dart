import 'package:flutter/material.dart';


class SpotifyAlertDialog extends StatelessWidget {
  const SpotifyAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF1DD05D),
      title: Text("Open Spotify In Background"),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
      content: Builder(
        builder: (context){
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Container(
            height: height*0.2,
            width: width*0.7,
            child: Text(
              "The Spotify Api allows playback only from active devices.\nTo make your device active please open spotify app in the background and show some activity (like playing a song for a second).",
            ),
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF222222),
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          ),
          child: Text(
            "OK",
            style: TextStyle(
                fontSize: 20
            ),
          ),
        ),
      ],
    );
  }
}