import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;


class VideoCaht extends StatefulWidget {
  final String token;
  final String channel;

  VideoCaht(this.token, this.channel);

  @override
  _VideoCahtState createState() => _VideoCahtState();
}

class _VideoCahtState extends State<VideoCaht> {
  int? _remoteUid;
  late RtcEngine _engine;
  //String token = "0064f2f949fbda447589d5cbda957cd1d9bIADrYCQanPa/z2UndkXo1DE/PIgGC8WJ9njcSokz9pqfFFR75ncAAAAAEACOYDhkLvFrYQEAAQAr8Wth";

  @override
  void initState() {
    super.initState();

    initAgora();
  }


  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();
    //create the engine
    _engine = await RtcEngine.create("4f2f949fbda447589d5cbda957cd1d9b");
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        
      ),
    );

    await _engine.joinChannel(widget.token, widget.channel, null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AMR Doctor Video Call'),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 140,
              child: Center(
                child: RtcLocalView.SurfaceView(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _engine.leaveChannel();
          Navigator.pop(context);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.call),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid!);
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}