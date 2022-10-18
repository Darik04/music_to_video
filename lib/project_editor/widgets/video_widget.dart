import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_to_video/project_editor/models/editor_model.dart';

class VideoWidget extends StatefulWidget {
  final double pps;
  final bool isCuttingVideo;
  Duration position;
  final EditorModel editorModel;
  final Function(Duration startDuration, Duration endDuration) onCut;
  final Function(int seconds) onPositionChange;
  final Stream<List<Uint8List>> thumbnailsStream;
  VideoWidget({required this.thumbnailsStream, required this.pps, required this.isCuttingVideo, required this.position, required this.editorModel, required this.onCut, required this.onPositionChange});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  int isDragged = 0;
  bool isDraggedPosition = false;
  Duration position = Duration.zero;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    position = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    print('PPS IS: ${widget.pps}');
    double start = (widget.editorModel.startCutDuration.inSeconds*widget.pps)-4;
    double end = (widget.editorModel.endCutDuration.inSeconds*widget.pps)-4;
    bool isLeftPadding = (widget.editorModel.durationVideo.inSeconds/2) < (isDraggedPosition ? position.inSeconds : widget.position.inSeconds);
    bool isRightPadding = (widget.editorModel.durationVideo.inSeconds/2) > (isDraggedPosition ? position.inSeconds : widget.position.inSeconds);
    double leftOffset = (isDraggedPosition 
      ? (widget.pps*position.inSeconds-(isLeftPadding?0:10)) 
      : (widget.pps*widget.position.inSeconds-(isLeftPadding?0:10))
    );
    if(leftOffset.isNegative){
      leftOffset = 0;
    }
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
          child: StreamBuilder<List<Uint8List>>(
            stream: widget.thumbnailsStream,
            builder: (_, snapshot) {
              return ClipRRect(
            borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: !snapshot.hasData
                  ? []
                  : snapshot.data!.map((e) 
                    => snapshot.data!.length == 8
                    ? Expanded(
                      child: Image.memory(
                        e, 
                        height: double.infinity, 
                        fit: BoxFit.cover,
                      ),
                    )
                    : Container(
                      constraints: BoxConstraints(maxWidth: 50),
                      child: Image.memory(
                        e, 
                        height: double.infinity, 
                        fit: BoxFit.cover,
                      ),
                    )
                  ).toList()
                ),
              );
            }
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
              height: isDragged == 1 || widget.isCuttingVideo ? 50 : 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isCuttingVideo ? Color(0xFFFDFEFF).withOpacity(0.7) : Color(0xFFF39530),
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
              height: isDragged == 2 || widget.isCuttingVideo ? 50 : 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isCuttingVideo ? Color(0xFFFDFEFF).withOpacity(0.7) : Color(0xFFF39530),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: (details){
            onDragUpdatePosition(details.delta.dx);
          },
          onHorizontalDragEnd: (_){
            widget.onPositionChange(position.inSeconds);
            setState(() {
              widget.position = position;
              isDraggedPosition = false;
            });
          },
          onHorizontalDragStart: (_){
            setState(() {
              isDraggedPosition = true;
            });
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.only(
              left: isLeftPadding ? 8 : 0,
              right: isRightPadding ? 8 : 0
            ),
            child: Container(
              margin: EdgeInsets.only(left: leftOffset),
              width: 2,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFEF7C00),
                borderRadius: BorderRadius.circular(5)
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

  void onDragUpdatePosition(double deltaX){
    deltaX = deltaX.isNegative ? deltaX/2 : deltaX;
    int seconds = (deltaX/widget.pps+position.inSeconds).toInt();
    int secondsComplete = 0;
    if(seconds <= 0){
      secondsComplete = 0;
    }else if(seconds >= widget.editorModel.durationVideo.inSeconds){
      secondsComplete = widget.editorModel.durationVideo.inSeconds;
    }else{
      secondsComplete = seconds;
    }
    setState(() {
      position = Duration(
        seconds: secondsComplete
      );
    });
  }

  void onCut(){
    widget.onCut(widget.editorModel.startCutDuration, widget.editorModel.endCutDuration);
  }
}