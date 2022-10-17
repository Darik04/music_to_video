import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_to_video/flutter_flow/flutter_flow_theme.dart';

class AudioWidget extends StatefulWidget {
  final String audio;
  final Duration videoDuration;
  const AudioWidget({
    Key? key,
    required this.audio,
    required this.videoDuration,
  }) : super(key: key);

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  double widthContainer = 10;
  int listLength = 0;
  @override
  void initState() {
    print('object123: ${widget.audio}');


    setDuration();
    
    super.initState();
  }

  void setDuration() async {
    await _audioPlayer.setSource(UrlSource(widget.audio));
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    duration = (await _audioPlayer.getDuration())!;
    print('GOTTTT: ${duration}');
    setState(() {
      setHeight();
    });
  }
  void setHeight(){
    widthContainer = ((MediaQuery.of(context).size.width * 0.85) / 100) *
                                (duration.inSeconds ~/
                                    (widget.videoDuration.inSeconds / 100)) > 1000 ? 1000 : ((MediaQuery.of(context).size.width * 0.85) / 100) *
                                (duration.inSeconds ~/
                                    (widget.videoDuration.inSeconds / 100)); 
    listLength = (((MediaQuery.of(context).size.width * 0.85) / 100) *
                                (duration.inSeconds /
                                    (widget.videoDuration.inSeconds / 100)) /
                                24).toInt();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Container(
        width: double.infinity,
        height: 66,
        decoration: BoxDecoration(),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 66,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(27, 0, 0, 2),
                    child: Text(
                      'Upbeat',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Container(
                          width: 3,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xFFF39530),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: widthContainer,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFEF7C00),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: List<Widget>.generate(
                            listLength,
                            (index) => SvgPicture.asset(
                              'assets/images/AddTrack.svg',
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 3,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFFF39530),
                            width: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
