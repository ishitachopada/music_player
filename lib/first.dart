import 'package:flutter/material.dart';
import 'package:music_player/second.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> getallsongs() async {
    List<SongModel> allsongs = await _audioQuery.querySongs();
    return allsongs;
  }

  getpermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    getpermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        toolbarHeight: 60,
        title: Center(child: Text("Music Player")),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getallsongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<SongModel> songs = snapshot.data as List<SongModel>;
            return ListView.builder(
              itemBuilder: (context, index) {
                SongModel s = songs[index];
                return Card(
                  color: Colors.black,
                  shadowColor: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return second(songs,index);
                      },));
                    },
                    title: Text(
                      "${s.title}",
                      style: TextStyle(color: Colors.white),
                    ),
                    // duration is always displayed in millisecond
                    subtitle: Text(
                      "${s.artist}",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                );
              },
              itemCount: songs.length,
            );
          } else {
            return Center(child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
        },
      ),
    );
  }
}
