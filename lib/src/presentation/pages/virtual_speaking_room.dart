// lib/src/presentation/pages/virtual_speaking_room.dart
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VirtualSpeakingRoom extends StatefulWidget {
  final MediaStream localStream;
  final bool isCameraOn;
  final bool isMicOn;

  VirtualSpeakingRoom({
    required this.localStream,
    required this.isCameraOn,
    required this.isMicOn,
  });

  @override
  _VirtualSpeakingRoomState createState() => _VirtualSpeakingRoomState();
}

class _VirtualSpeakingRoomState extends State<VirtualSpeakingRoom> {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  bool _isCameraOn = true;
  bool _isMicOn = true;

  @override
  void initState() {
    super.initState();
    _isCameraOn = widget.isCameraOn;
    _isMicOn = widget.isMicOn;
    _initializeRenderers();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    _startLocalStream();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    super.dispose();
  }

  Future<void> _startLocalStream() async {
    _localRenderer.srcObject = widget.localStream;
    final videoTrack = widget.localStream.getVideoTracks().first;
    videoTrack.enabled = _isCameraOn;
    setState(() {}); // Làm mới UI để hiển thị video stream
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Virtual Speaking Room',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 150, // Thiết lập kích thước nhỏ hơn cho góc trái
                height: 150,
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: RTCVideoView(_localRenderer, mirror: true), // Hiển thị camera chính của người dùng
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarButton(
            _isMicOn ? Icons.mic : Icons.mic_off,
            _isMicOn ? 'Mute' : 'Unmute',
            _toggleMic,
          ),
          _buildBottomBarButton(
            _isCameraOn ? Icons.videocam : Icons.videocam_off,
            _isCameraOn ? 'Turn off camera' : 'Turn on camera',
            _toggleCamera,
          ),
          _buildBottomBarButton(Icons.call_end, 'End Call', () {
            Navigator.pop(context); // Thoát khỏi phòng họp
          }),
        ],
      ),
    );
  }

  Widget _buildBottomBarButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12.0)),
      ],
    );
  }

  void _toggleCamera() {
    final videoTrack = widget.localStream.getVideoTracks().first;
    videoTrack.enabled = !videoTrack.enabled;
    setState(() {
      _isCameraOn = videoTrack.enabled;
    });
  }

  void _toggleMic() {
    final audioTrack = widget.localStream.getAudioTracks().first;
    audioTrack.enabled = !audioTrack.enabled;
    setState(() {
      _isMicOn = audioTrack.enabled;
    });
  }
}
