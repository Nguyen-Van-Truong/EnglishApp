// lib/src/presentation/pages/setup_meeting_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'virtual_speaking_room.dart';

class SetupMeetingPage extends StatefulWidget {
  @override
  _SetupMeetingPageState createState() => _SetupMeetingPageState();
}

class _SetupMeetingPageState extends State<SetupMeetingPage> {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  bool _isCameraOn = true;
  bool _isMicOn = true;

  @override
  void initState() {
    super.initState();
    _initializeRenderer();
    _requestPermissions();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _localStream?.dispose();
    super.dispose();
  }

  Future<void> _initializeRenderer() async {
    await _localRenderer.initialize();
  }

  Future<void> _requestPermissions() async {
    final status = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (status[Permission.camera] == PermissionStatus.granted &&
        status[Permission.microphone] == PermissionStatus.granted) {
      _startLocalStream();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera and microphone permissions are required to use this feature.'),
        ),
      );
    }
  }

  Future<void> _startLocalStream() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': _isMicOn,
      'video': _isCameraOn,
    };

    try {
      _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localRenderer.srcObject = _localStream;
      setState(() {}); // Refresh the UI
    } catch (e) {
      print('Error starting local stream: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to access camera and microphone. Please check your settings.')),
      );
    }
  }

  void _toggleCamera() {
    if (_localStream != null) {
      final videoTrack = _localStream!.getVideoTracks().first;
      videoTrack.enabled = !videoTrack.enabled;
      setState(() {
        _isCameraOn = videoTrack.enabled;
      });
    }
  }

  void _toggleMic() {
    if (_localStream != null) {
      final audioTrack = _localStream!.getAudioTracks().first;
      audioTrack.enabled = !audioTrack.enabled;
      setState(() {
        _isMicOn = audioTrack.enabled;
      });
    }
  }

  void _joinMeeting() {
    if (_localStream != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VirtualSpeakingRoom(
            localStream: _localStream!,
            isCameraOn: _isCameraOn,
            isMicOn: _isMicOn,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot join the meeting. Please check your permissions.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Meeting'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: RTCVideoView(_localRenderer, mirror: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    _isCameraOn ? Icons.videocam : Icons.videocam_off,
                    color: _isCameraOn ? Colors.green : Colors.red,
                  ),
                  onPressed: _toggleCamera,
                  tooltip: _isCameraOn ? 'Turn off camera' : 'Turn on camera',
                ),
                IconButton(
                  icon: Icon(
                    _isMicOn ? Icons.mic : Icons.mic_off,
                    color: _isMicOn ? Colors.green : Colors.red,
                  ),
                  onPressed: _toggleMic,
                  tooltip: _isMicOn ? 'Mute microphone' : 'Unmute microphone',
                ),
                ElevatedButton(
                  onPressed: _joinMeeting,
                  child: Text('Join Meeting'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
