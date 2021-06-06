import 'package:flutter/material.dart';
import 'package:tictactoe/services/player.dart';

class MusicButtons extends StatefulWidget {
  @override
  _MusicButtonsState createState() => _MusicButtonsState();
}

class _MusicButtonsState extends State<MusicButtons> {

  bool _isShuffle = false;
  bool _isRepeat = false;
  bool _isPlaying = true;

  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
            padding: EdgeInsets.all(20),
            child: Expanded(
              child: GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: (){
                        if(_isRepeat) {
                          Player().repeat("off");
                          setState(() {
                            _isRepeat = false;
                          });
                        }
                        else{
                          Player().repeat("track");
                          setState(() {
                            _isRepeat = true;
                          });
                          if(_isShuffle){
                            Player().shuffle(false);
                            setState(() {
                              _isShuffle = false;
                            });
                          }
                        }

                      },
                      child: Icon(
                        Icons.repeat_outlined,
                        size: 30,
                        color: _isRepeat?Colors.white:Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: (){
                        Player().skipToPreviousTrack();
                      },
                      child: Icon(
                        Icons.skip_previous,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: _isPlaying?GestureDetector(
                      onTap: () {
                        Player().pause();
                        setState(() {
                          _isPlaying = false;
                        });
                      },
                      child: Icon(
                        Icons.pause_circle_filled,
                        size: 60,
                        color: Colors.white,
                      ),
                    ):GestureDetector(
                      onTap: (){
                        Player().play();
                        setState(() {
                          _isPlaying = true;
                        });
                      },
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 60,
                        color: Colors.white,
                      ),
                    )
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () => Player().skipToNextTrack(),
                      child: Icon(
                        Icons.skip_next,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        if(_isShuffle){
                          Player().shuffle(false);
                          setState(() {
                            _isShuffle = false;
                          });
                        }
                        else{
                          Player().shuffle(true);
                          setState(() {
                            _isShuffle = true;
                          });
                          if(_isRepeat){
                            setState(() {
                              Player().repeat("off");
                              _isRepeat = false;
                            });
                          }
                        }
                      },
                      child: Icon(
                        Icons.shuffle,
                        size: 30,
                        color: _isShuffle?Colors.white:Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      );
  }
}
