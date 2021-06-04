import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/services/playRequest.dart';
import 'package:tictactoe/ui/pages/selectPlayMode.dart';
import 'package:tictactoe/ui/widgets/spotifyAlertDialog.dart';

class SpotifyPlaylists extends StatefulWidget {
  var authenticationToken;

  SpotifyPlaylists({this.authenticationToken});
  @override
  _SpotifyPlaylistsState createState() => _SpotifyPlaylistsState();
}

class _SpotifyPlaylistsState extends State<SpotifyPlaylists> {

  StreamController _playlistsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future fetchPlaylist() async{
    final response = await http.get(Uri.parse("https://api.spotify.com/v1/me/playlists"),
      headers: {
        "Authorization": "Bearer " + widget.authenticationToken.toString(),
      }
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)["items"];
    } else {
      print(response.body);
      throw Exception('Failed to load playlist');
    }
  }

  loadPlaylists() async {
    fetchPlaylist().then((res) async {
      _playlistsController.add(res);
      return res;
    });
  }

  @override
  void initState() {
    _playlistsController = new StreamController();
    loadPlaylists();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: SafeArea(
        child: StreamBuilder(
          stream: _playlistsController.stream,
          builder: (BuildContext context , AsyncSnapshot snapshot){
            if(snapshot.hasError){
              return Text(snapshot.error);
            }
            if(snapshot.hasData){
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text("Select your Playlist",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFF1DD05D),
                    thickness: 0.75,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,  index){
                        var playlist = snapshot.data[index];
                        return GestureDetector(
                          onTap: () async{
                            print("tapped");
                            print(playlist["uri"]);
                            try {
                                PlayRequest playReq = new PlayRequest(playlist["uri"] , widget.authenticationToken.toString());
                                await playReq.sendPlayRequest();
                                print("Status CODE:   "+ playReq.statusCode.toString());
                                if(playReq.statusCode == 403){
                                  Fluttertoast.showToast(msg: "You are not a Spotify Premium Customer :(", toastLength: Toast.LENGTH_LONG);
                                  Navigator.pop(context);
                                }
                                else if(playReq.statusCode == 404){
                                    showDialog(
                                        context: context,
                                        builder: (_) => SpotifyAlertDialog()
                                    );
                                }
                                else {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectMode(isMusic: true,)));
                                }
                            }catch(e){
                              print(e);
                            }
                          },
                          child: ListTile(
                            title: Text(
                                playlist["name"],
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                  ),
                                ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context , index){
                        return Divider(
                          color: Colors.black,
                          thickness: 0.75,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF1DD05D))
                ),
              );
            }

            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Text('No Playlists');
            }

            return Text("");
          },
        ),
      ),
    );
  }
}

