import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'chew.dart';

class VideosViewer extends StatefulWidget {
  @override
  _VideosViewerState createState() => _VideosViewerState();
}

class _VideosViewerState extends State<VideosViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Videos'),
        ),
        body: Container(
            child: ListView(children: [
          Card(
              elevation: 5,
              child: ChewieListItem(
                videoPlayerController: VideoPlayerController.network(
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                ),
                looping: false,
              ))
        ]))
        // body: Container(
        //   child: FutureBuilder<GetVideos>(
        //     future: Utils().fetchvideos(),
        //     builder: (context,snapshot){
        //       if(snapshot.hasData){
        //         return ListView.builder(
        //           itemCount: snapshot.data.data.length,
        //           shrinkWrap: true,
        //           itemBuilder: (BuildContext context, index ){
        //             return
        //               Card(
        //                 elevation: 5,
        //               child:ChewieListItem(
        //               videoPlayerController: VideoPlayerController.network(
        //                 Utils().image_base_url+'${snapshot.data.data[index].file}',
        //               ),
        //             ));
        //           },
        //         );
        //       }
        //       return Center(child: CircularProgressIndicator());
        //     },
        //   ),
        // ),
        );
  }
}
