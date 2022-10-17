import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_to_video/project_editor/models/editor_model.dart';
class VideoWidget extends StatefulWidget {
  final int countBits; 
  final double pps;
  final Duration position;
  final EditorModel editorModel;
  final Function(Duration startDuration, Duration endDuration) onCut;
  VideoWidget({required this.countBits, required this.pps, required this.position, required this.editorModel, required this.onCut});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  int isDragged = 0;

  @override
  Widget build(BuildContext context) {
    print('PPS IS: ${widget.pps}');
    double start = (widget.editorModel.startCutDuration.inSeconds*widget.pps)-4;
    double end = (widget.editorModel.endCutDuration.inSeconds*widget.pps)-4;
    print('START: $start and END: $end');
    return Stack(
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
        Container(
          margin: EdgeInsets.only(left: widget.pps*widget.position.inSeconds),
          width: 2,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFEF7C00),
            borderRadius: BorderRadius.circular(5)
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: start <= 0 ? 0 : start),
          child: GestureDetector(
            onHorizontalDragUpdate: (details){
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
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 3,
              margin: EdgeInsets.only(right: 5),
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
          padding: EdgeInsets.only(left: end <= 0 ? 0 : end-5),
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
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 3,
              margin: EdgeInsets.only(left: 5),
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
    );
  }





  void onDragUpdateEnd(double deltaX){
    int seconds = (deltaX/widget.pps+widget.editorModel.endCutDuration.inSeconds).toInt();
    int secondsComplete = 0;
    if(seconds >= widget.editorModel.durationVideo.inSeconds){
      secondsComplete = widget.editorModel.durationVideo.inSeconds;
    }else if(seconds < (widget.editorModel.startCutDuration.inSeconds+(widget.editorModel.durationVideo.inSeconds*0.2).toInt())){
      secondsComplete = widget.editorModel.startCutDuration.inSeconds+(widget.editorModel.durationVideo.inSeconds*0.2).toInt();
    }else{
      secondsComplete = seconds;
    }
    setState(() {
      widget.editorModel.endCutDuration = Duration(
        seconds: secondsComplete
      );
    });
  }


  void onDragUpdateStart(double deltaX){
    int seconds = (deltaX/widget.pps+widget.editorModel.startCutDuration.inSeconds).toInt();
    int secondsComplete = 0;
    if(seconds <= 0){
      secondsComplete = 0;
    }else if(seconds > (widget.editorModel.endCutDuration.inSeconds-(widget.editorModel.durationVideo.inSeconds*0.2).toInt())){
      secondsComplete = widget.editorModel.endCutDuration.inSeconds-(widget.editorModel.durationVideo.inSeconds*0.2).toInt();
    }else{
      secondsComplete = seconds;
    }
    setState(() {
      widget.editorModel.startCutDuration = Duration(
        seconds: secondsComplete
      );
    });
  }

  void onCut(){
    widget.onCut(widget.editorModel.startCutDuration, widget.editorModel.endCutDuration);
  }
}