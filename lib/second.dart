import 'package:flutter/material.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';

class second extends StatefulWidget {
  List<SongModel> song;
  int index;

  second(this.song, this.index);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  bool play = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text("MUSIC")),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage("myimage/music.jpg"),
            fit: BoxFit.cover,
          ),
          Text(
            "${widget.song[widget.index].title}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    if (widget.index != 0) {
                      setState(() {
                        widget.index--;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      play = !play;
                    });
                  },
                  icon: play == true
                      ? Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.pause,
                          color: Colors.white,
                        )),
              IconButton(
                  onPressed: () {
                    if (widget.index != widget.song.length - 1) {
                      setState(() {
                        widget.index++;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
