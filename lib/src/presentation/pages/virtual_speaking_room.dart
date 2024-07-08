import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';

class VirtualSpeakingRoom extends StatefulWidget {
  @override
  _VirtualSpeakingRoomState createState() => _VirtualSpeakingRoomState();
}

class _VirtualSpeakingRoomState extends State<VirtualSpeakingRoom> {
  final List<RTCVideoRenderer> _remoteRenderers = [];
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;

  @override
  void initState() {
    super.initState();
    _initializeRenderersAndPermissions();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _localStream?.dispose();
    for (var renderer in _remoteRenderers) {
      renderer.dispose();
    }
    super.dispose();
  }

  Future<void> _initializeRenderersAndPermissions() async {
    await _requestPermissions();
    await _initializeRenderers();
    await _startLocalStream();
  }

  Future<void> _requestPermissions() async {
    final status = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (status[Permission.camera] != PermissionStatus.granted ||
        status[Permission.microphone] != PermissionStatus.granted) {
      // Show a message to the user explaining why the permissions are necessary
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera and microphone permissions are required to use this feature.')),
      );
    }
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    // Initialize other renderers for remote streams if needed
  }

  Future<void> _startLocalStream() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      },
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
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Show meeting options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust based on number of participants
                childAspectRatio: 1.0,
              ),
              itemCount: _remoteRenderers.length + 1,
              itemBuilder: (context, index) {
                if (index == _remoteRenderers.length) {
                  // Place local renderer at the end (right side)
                  return _buildVideoTile(_localRenderer, isLocal: true);
                } else {
                  return _buildVideoTile(_remoteRenderers[index]);
                }
              },
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildVideoTile(RTCVideoRenderer renderer, {bool isLocal = false}) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: RTCVideoView(renderer, mirror: isLocal),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarButton(Icons.mic_off, 'Mute', () {
            // Handle mute/unmute
          }),
          _buildBottomBarButton(Icons.videocam_off, 'Camera', () {
            // Handle camera on/off
            _toggleCamera();
          }),
          _buildBottomBarButton(Icons.screen_share, 'Share Screen', () {
            // Handle screen share
          }),
          _buildBottomBarButton(Icons.call_end, 'End Call', () {
            // Handle end call
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
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ],
    );
  }

  void _toggleCamera() {
    if (_localStream != null) {
      final videoTrack = _localStream!.getVideoTracks().first;
      videoTrack.enabled = !videoTrack.enabled;
    }
  }
}
