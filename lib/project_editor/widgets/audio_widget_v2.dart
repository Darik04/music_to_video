import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_to_video/flutter_flow/flutter_flow_theme.dart';
import 'package:music_to_video/project_editor/models/audio_model.dart';

import '../helpers/time_helper.dart';
class AudioWidgetV2 extends StatefulWidget {
  final int countBits; 
  final double pps;
  final AudioModel audioModel;
  final Function(Duration startDuration, Duration endDuration) onCut;
  AudioWidgetV2({required this.countBits, required this.pps, required this.audioModel, required this.onCut});

  @override
  State<AudioWidgetV2> createState() => _AudioWidgetV2State();
}

class _AudioWidgetV2State extends State<AudioWidgetV2> {

  int isDragged = 0;

  @override
  Widget build(BuildContext context) {
    double start = (widget.audioModel.startCutDuration.inMilliseconds*(widget.pps/1000))-4;
    double end = (widget.audioModel.endCutDuration.inMilliseconds*(widget.pps/1000))-4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if(widget.audioModel.trackName != null)
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 9, bottom: 2),
            child: Text(widget.audioModel.trackName!, style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              color: Color(0xFFFDFEFF),
              fontSize: 9,
              fontWeight: FontWeight.w300,
            ),),
          ),
        ),
        Stack(
          // mainAxisSize: MainAxisSize.max,
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDragged != 0 ? Color(0xFFEF7C00).withOpacity(0.6) : Color(0xFFEF7C00),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: List<Widget>.generate(
                  widget.countBits,
                  (index) => SvgPicture.asset(
                    'assets/images/AddTrack.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: start <= 0 ? 0 : start),
              child: GestureDetector(
                onHorizontalDragUpdate: (details){
                  if(details.delta.dx != 0)
                  onDragUpdateStart(details.delta.dx);
                },
                onHorizontalDragStart: (_){
                  setState(() {
                    isDragged = 1;
                  });
                },
                onHorizontalDragEnd: (_){
                  setState(() {
                    isDragged = 0;
                  });
                  onCut();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 3,
                  margin: EdgeInsets.only(right: 30),
                  height: isDragged == 1 ? 50 : 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFF39530),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: end <= 0 ? 0 : end-30),
              child: GestureDetector(
                onHorizontalDragUpdate: (details){
                  onDragUpdateEnd(details.delta.dx);
                },
                onHorizontalDragStart: (_){
                  setState(() {
                    isDragged = 2;
                  });
                },
                onHorizontalDragEnd: (_){
                  setState(() {
                    isDragged = 0;
                  });
                  onCut();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 3,
                  margin: EdgeInsets.only(left: 30),
                  height: isDragged == 2 ? 50 : 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFF39530),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }





  void onDragUpdateEnd(double deltaX){
    double seconds = (toMicroSeconds(deltaX/widget.pps)+widget.audioModel.endCutDuration.inMicroseconds);
    double secondsComplete = 0;
    if(seconds >= widget.audioModel.duration.inMicroseconds){
      secondsComplete = widget.audioModel.duration.inMicroseconds.toDouble();
    }else if(seconds < (widget.audioModel.startCutDuration.inMicroseconds+(widget.audioModel.duration.inMicroseconds*0.2))){
      secondsComplete = widget.audioModel.startCutDuration.inMicroseconds+(widget.audioModel.duration.inMicroseconds*0.2);
    }else{
      secondsComplete = seconds;
    }
    setState(() {
      widget.audioModel.endCutDuration = Duration(
        microseconds: secondsComplete.round()
      );
    });
  }


  void onDragUpdateStart(double deltaX){
    double seconds = (toMicroSeconds(deltaX/widget.pps)+widget.audioModel.startCutDuration.inMicroseconds);
    double secondsComplete = 0;
    if(seconds <= 0){
      secondsComplete = 0;
    }else if(seconds > (widget.audioModel.endCutDuration.inMicroseconds-(widget.audioModel.duration.inMicroseconds*0.2))){
      secondsComplete = widget.audioModel.endCutDuration.inMicroseconds-(widget.audioModel.duration.inMicroseconds*0.2);
    }else{
      secondsComplete = seconds;
    }
    setState(() {
      widget.audioModel.startCutDuration = Duration(
        microseconds: secondsComplete.round()
      );
    });
  }

  void onCut(){
    widget.onCut(widget.audioModel.startCutDuration, widget.audioModel.endCutDuration);
  }
}