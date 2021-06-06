import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/ui/pages/selectPlayMode.dart';
import 'package:tictactoe/ui/pages/spotifyPlaylists.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void markOnboarded() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setBool("onboardingDone", true);
  }


  @override
  void initState() {
    markOnboarded();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width,
              child: Text("Tic Tac Toe",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 40,
                        color: Colors.white
                    )
                ),
              ),
            ),
            Image.asset("images/ticTacToe.png" , width: width*0.8,),
            Column(
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1DD05D),
                      padding: EdgeInsets.only(left: 20 , right: 20, top: 10 , bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    onPressed: () async{
                      var authenticationToken = await SpotifySdk.getAuthenticationToken(clientId: "831a3456d41543ee96d7bd4ad7ab8432", redirectUrl: "spotify-sdk://auth", scope: "app-remote-control,user-modify-playback-state,playlist-read-private,user-read-currently-playing,user-read-playback-state");

                      //save in shared prefs
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString("authenticationToken", authenticationToken.toString());

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SpotifyPlaylists(authenticationToken: authenticationToken,)));
                      print("My auth token:       " + authenticationToken);
                    },
                    label: Text(
                      "Spotify Sign In",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    icon: Icon(Icons.music_note , color: Colors.white,),
                  ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectMode(isMusic: false,)));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.only(left: 20 , right: 20, top: 10 , bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    icon: Icon(
                      Icons.sports_esports,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Play without Music",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
