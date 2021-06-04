import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/services/playRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tictactoe/ui/pages/gamePage.dart';
import 'package:tictactoe/ui/pages/selectPlayMode.dart';


class SelectDevice extends StatefulWidget {

  final String contextUri;
  SelectDevice({this.contextUri});

  @override
  _SelectDeviceState createState() => _SelectDeviceState();
}

class _SelectDeviceState extends State<SelectDevice> {
  StreamController _devicesController;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future fetchDevice() async{
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("authenticationToken");
    print("THIS IS TOKEN:      " + token);

    final response = await http.get(Uri.parse("https://api.spotify.com/v1/me/player/devices"),
        headers: {
          "Authorization": "Bearer " + token.toString(),
        }
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)["devices"];
    } else {
      print(response.body);
      throw Exception('Failed to load device');
    }
  }

  loadDevices() async {
    fetchDevice().then((res) async {
      _devicesController.add(res);
      return res;
    });
  }

  void initState() {
    _devicesController = new StreamController();
    loadDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: SafeArea(
        child: StreamBuilder(
            stream: _devicesController.stream,
            builder: (BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.hasError){
                return Text(snapshot.error);
              }
              if(snapshot.hasData){
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text("Select your Device",
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
                          var device = snapshot.data[index];
                          return GestureDetector(
                            onTap: () async{
                              try {
                                var prefs = await SharedPreferences.getInstance();
                                String token = prefs.getString("authenticationToken");
                                print("THIS IS TOKEN:      " + token);

                                PlayRequest playReq = new PlayRequest.overloadedConstructor(widget.contextUri , token , device["id"]);
                                await playReq.senPlayRequestWithDeviceId();

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectMode(isMusic: true,)));
                              }catch(e){
                                print(e);
                              }
                            },
                            child: ListTile(
                              title: Text(
                                device["name"],
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
                            color: Colors.white,
                            thickness: 2,
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
                return Text('No Devices');
              }

              return Text("");
            }
        ),
      ),
    );
  }
}
