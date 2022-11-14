import 'dart:async';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:music_to_video/project_editor/done_page.dart';
import 'package:music_to_video/project_editor/loader_page.dart';
import 'package:music_to_video/project_editor/widgets/blur_filter.dart';
import 'package:music_to_video/project_editor/widgets/video_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_to_video/project_editor/helpers/editor_cache.dart';
import 'package:music_to_video/project_editor/models/audio_model.dart';
import 'package:music_to_video/project_editor/models/editor_model.dart';
import 'package:music_to_video/project_editor/widgets/audio_widget_v2.dart';
import 'package:music_to_video/project_editor/widgets/loader.dart';
import '../components/add_track_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../main/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_editor/timeline_editor.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'helpers/data_saver.dart';
import 'helpers/thumbnail.dart';

class ProjectEditorWidget extends StatefulWidget {
  final EditorModel? editorModel;
  const ProjectEditorWidget({
    required this.editorModel,
    Key? key,
    this.file,
  }) : super(key: key);

  final File? file;

  @override
  _ProjectEditorWidgetState createState() => _ProjectEditorWidgetState();
}

class _ProjectEditorWidgetState extends State<ProjectEditorWidget> {

  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  Duration videoDur = Duration.zero;
  String outputGlobalPath = '';

  bool _exported = false;
  late VideoPlayerController _controller;
  List<AudioModel> _records = [];
  List<String> cacheFiles = [];
  

  double position = 0;
  bool isCuttingVideo = false;
  int volume = 1;
  EditorModel? editorModel;
  late StreamController<int> positionController = StreamController<int>();
  late Timer progressTimer;
  late final StreamController<List<Uint8List>> _stream = StreamController<List<Uint8List>>();

  File? audioFile;

  TimelineEditorTrack getTrackByIndex(int i, double pps, Duration duration){
    print('LLL: ${pps.runtimeType} : ${duration}');
    int index = i-1;
    return TimelineEditorTrack(
      defaultColor: Colors.transparent,
      boxes: [
        TimelineEditorBox(
          _records[index].startDuration, 
          _records[index].duration,
          onMoved: (d){
            moveBox(d, index, _records[index].duration);
          },
          onMovedEnd: () => print('end moved'),
          child: AudioWidgetV2(
            pps: pps,
            audioModel: _records[index],
            onCut: (startDuration, endDuration){
              _controller.pause();
              _records[index].startDuration = Duration(milliseconds: _records[index].startDuration.inMilliseconds+startDuration.inMilliseconds);
              _records[index].duration = Duration(
                milliseconds: _records[index].duration.inMilliseconds
                  - startDuration.inMilliseconds
                  - (_records[index].duration.inMilliseconds-endDuration.inMilliseconds)
              );
              _records[index].endCutDurationForExport = Duration(milliseconds: _records[index].duration.inMilliseconds-endDuration.inMilliseconds);
              _records[index].startCutDurationForExport = Duration(milliseconds: _records[index].startCutDurationForExport.inMilliseconds+startDuration.inMilliseconds);
              _records[index].endCutDuration = _records[index].duration;
              _records[index].startCutDuration = Duration(seconds: 0);
              setState(() {});
            },
            countBits: (pps*_records[index].duration.inSeconds/24).floor(),
          )
        ),
      ],
      pixelsPerSeconds: pps,
      duration: videoDur,
      trackHeight: 72,
    );
  }

  Future<String> generateFFMPEGCommand() async{
    String audioInputPath = _controller.dataSource;
    for(var i = 0; _records.length > i; i++){
      _records[i].pathToAudioCutted = await cutAudio(_records[i].pathToAudio, _records[i].startCutDurationForExport, _records[i].duration);
      print('AUDIO CUTTED INDEX $i: ${_records[i].pathToAudioCutted}');
      cacheFiles.add(_records[i].pathToAudioCutted);
      _exportingProgress.value += (6/100);
      if(volume == 1 && i == 0){
        audioInputPath =  _controller.dataSource;
      }
      if(volume == 0 && _records.length == 1){
        audioInputPath =  _controller.dataSource;
        audioInputPath = await mergeAudio( _controller.dataSource, audioInputPath, _records[i].pathToAudioCutted, Duration(seconds: 0), _records[i].startDuration, videoDur, muteAudio1: true);
        cacheFiles.add(audioInputPath);
      }else if(volume == 0 && i == 0){
        continue;
      }else if(volume == 0 && i == 1){
        audioInputPath = await mergeAudio( _controller.dataSource, _records[i-1].pathToAudioCutted, _records[i].pathToAudioCutted, _records[i-1].startDuration, _records[i].startDuration, videoDur);
        cacheFiles.add(audioInputPath);
      }else{
        audioInputPath = await mergeAudio( _controller.dataSource, audioInputPath, _records[i].pathToAudioCutted, Duration(seconds: 0), _records[i].startDuration, videoDur);
        cacheFiles.add(audioInputPath);
      }
      _exportingProgress.value += (6/100);
    }
    String command = '-i \'${ _controller.dataSource}\' -ss 00:00:00  -t 0${videoDur.toString().substring(0, 7)}';
    final String tempPath = (await getTemporaryDirectory()).path;
    final int epoch = DateTime.now().millisecondsSinceEpoch;
    final String videoOutputPath = "$tempPath/MUSIC_TO_VIDEO_$epoch.mp4";
    command += ' -i \'$audioInputPath\'';
    // for(var i = 0; _records.length > i; i++){
    //   command += ' -itsoffset 0${_records[i].startDuration.toString().substring(0, 7)} -i \'${_records[i].pathToAudioCutted}\'';
    // }
    // command += ' -map ${volume == 0 ? '0:v' : '0'}';
    // for(var i = 0; _records.length > i; i++){
    //   command += ' -map ${i+1}:a';//${i+1}:a:0
    // }
    command += ' -map 0:v -map 1:a';
    
    command += ' -c copy';
    command += ' $videoOutputPath';
    outputGlobalPath = videoOutputPath;
    print('COMMAND IS: $command');
    return command;
  }

  void clearCache() async{
    print('CLEAR CACHE');
    for(var i = 0; cacheFiles.length > i; i++){
      await File(cacheFiles[i]).delete();
    }
  }

  void moveBox(Duration newStart, int index, Duration trackDuration) {
    if (_records[index].startDuration + newStart < Duration.zero || (_records[index].startDuration + newStart + trackDuration) >= editorModel!.durationFullTrack!) {
      newStart = Duration.zero;
    }
    setState(() {
      _records[index].startDuration += newStart;
    });
  }

  setValue(dynamic? value) async{
    if (value != null && _records.length <= 8) {
      print('SETTING: ${value}');
      final AudioPlayer newAudioPlayer = AudioPlayer();

      //Download to cache music!
      Loader(context: context).showMyDialog();
      final String tempPath = (await getTemporaryDirectory()).path;
      final String outputPath = "$tempPath";
      String audioPath = await downloadFile(value.audio ?? '', outputPath);
      Navigator.pop(context);

      await newAudioPlayer.setSource(DeviceFileSource(audioPath));
      _records.add(
        AudioModel(
          duration: (await newAudioPlayer.getDuration()) ?? Duration.zero, 
          startDuration: Duration(seconds: 0), 
          startCutDuration: Duration(seconds: 0), 
          startCutDurationForExport: Duration(seconds: 0), 
          endCutDuration: (await newAudioPlayer.getDuration()) ?? Duration.zero, 
          endCutDurationForExport: Duration(seconds: 0), 
          urlToAudio: value.audio ?? '', 
          trackName: value.trackName ?? '',
          pathToAudio: audioPath,
          audioPlayer: newAudioPlayer,
          pathToAudioCutted: ''
        )
      );
      if(_records.last.duration > (editorModel!.durationFullTrack ?? editorModel!.durationVideo)){
        editorModel!.durationFullTrack = (_records.last.duration+Duration(seconds: 1));
      }
      print('SET: ${_records}');
      setState(() {});
      saveChanges();
    }
    print(_records.length);
  }

  Timer? timer;
  void _startTimer(){
    if(timer == null || !timer!.isActive){
      timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        await handlerPlayer();
      });
    } 
  }

  handlerPlayer() async{
    // print('TIMER: ${_controller.isPlaying} : ${_records.length} :');
    for(var i = 0; _records.length > i; i++){
      Duration position = _controller.value.position;
      if(!_controller.value.isPlaying){
        //Если видео выкл
        if(_records[i].audioPlayer.state == PlayerState.playing){
          _records[i].audioPlayer.pause();
        }
        //Если аудио вкл и позиция видео больше конца аудио или позиция видео меньше старта аудио то Видео выкл(вырубаем) 
      }else if(_controller.value.position.inSeconds >= (_records[i].startDuration.inSeconds+_records[i].duration.inSeconds)
        || _controller.value.position.inSeconds < _records[i].startDuration.inSeconds){
          if(_records[i].audioPlayer.state == PlayerState.playing){
            _records[i].audioPlayer.pause();
          }
        //Если видео вкл и аудио выкл и 
      }else if(_controller.value.isPlaying && _records[i].audioPlayer.state != PlayerState.playing 
        && _controller.value.position.inSeconds >= _records[i].startDuration.inSeconds){
          _records[i].audioPlayer.pause();
          _records[i].audioPlayer.play(DeviceFileSource(_records[i].pathToAudio), position: Duration(seconds: (_controller.value.position.inSeconds-_records[i].startDuration.inSeconds)+_records[i].startCutDurationForExport.inSeconds));
      }else if(_controller.value.isPlaying
        && !(_controller.value.position.inSeconds - (((await _records[i].audioPlayer.getCurrentPosition())!.inSeconds-_records[i].startCutDurationForExport.inSeconds) + _records[i].startDuration.inSeconds)).isBetween(-2, 2)
        && _controller.value.position.inSeconds >= _records[i].startDuration.inSeconds){
          _records[i].audioPlayer.pause();
          _records[i].audioPlayer.play(DeviceFileSource(_records[i].pathToAudio), position: Duration(seconds: (_controller.value.position.inSeconds-_records[i].startDuration.inSeconds)+_records[i].startCutDurationForExport.inSeconds));
      }
    }
      
  }

  void _allPlayerPause(){
    _controller.pause();
    for(var record in _records){
      record.audioPlayer.pause();
    }
  }
  void _allPlayerDispose(){
    _controller.pause();
    _controller.dispose();
    saveChanges();
    for(var record in _records){
      record.audioPlayer.pause();
      record.audioPlayer.dispose();
    }
  }

  @override
  void initState() {
    print('EDITOR: ${widget.editorModel?.pathToVideo}');
    _controller = VideoPlayerController.file(
      widget.file != null ? widget.file! : File(widget.editorModel!.pathToVideo)
    )..initialize().then((_) async {
      await _controller.play();
      await _controller.pause();
      setEditor();
    });
    _startTimer();
    _controller.addListener(() {
      positionController.sink.add(_controller.value.position.inSeconds);
    });
    super.initState();
  }


  setEditor() async{
    if(widget.editorModel == null){
      setState(() {
        videoDur = _controller.value.duration;
      });
      editorModel = EditorModel(
        editorCode: DateTime.now().millisecondsSinceEpoch.toString(), 
        durationVideo: videoDur, 
        pathToVideo: widget.file!.path, 
        pathToOriginalVideo: widget.file!.path, 
        records: [], 
        endCutDuration: videoDur,
        durationFullTrack: videoDur,
        startCutDuration: Duration(seconds: 0),
        picture: null
      );
    }else{
      editorModel = widget.editorModel;
      videoDur = _controller.value.duration;
      editorModel!.durationVideo = _controller.value.duration;
      setState(() {});
      _records = editorModel!.records;
      for(int i = 0; i < _records.length; i++){
        AudioPlayer newAudioPlayer = AudioPlayer();
        await newAudioPlayer.setSource(DeviceFileSource(_records[i].pathToAudio));
        _records[i].audioPlayer = newAudioPlayer;
      }
      setState(() {});
    }
    getThumnails();
    saveChanges();
  }

  List<Uint8List> thumnails = [];
  getThumnails() async{
    for(var i = 1; i <= 8; i++){
      Uint8List? bytes = await generateThumbnail(editorModel!.pathToVideo, videoDur, i);
      if(bytes != null){
        thumnails.add(bytes);
      }
      _stream.sink.add(thumnails);
    }
  }
  
  _cutVideo(Duration startCutDuration, Duration endCutDuration) async{
    _controller.pause();
    Duration durVideo = videoDur;
    setState(() {
      isCuttingVideo = true;
    });
    String path = await cutVideo(_controller.dataSource, startCutDuration, Duration(seconds: (endCutDuration.inSeconds-startCutDuration.inSeconds)));
    print('CUTTED: ${path}');
    if(_controller.dataSource != editorModel!.pathToOriginalVideo){
      File(_controller.dataSource).delete();
    }
    _controller = VideoPlayerController.file(
      File(path)
    );
    _controller.initialize().then((_) async {
      print('INITED: ${_controller.value.duration}');
      thumnails = [];
      getThumnails();
      videoDur = _controller.value.duration;
      await _controller.play();
      await _controller.pause();
      editorModel!.pathToVideo = path;
      editorModel!.durationVideo = videoDur;
      editorModel!.durationFullTrack = _records.any((element) => element.duration > videoDur) ? editorModel!.durationFullTrack : videoDur;
      editorModel!.endCutDuration = _controller.value.duration;
      editorModel!.startCutDuration = Duration(seconds: 0);
      _controller.addListener(() {
        positionController.sink.add(_controller.value.position.inSeconds);
      });
      for(var i = 0; i < _records.length; i++){
        Duration offset = (startCutDuration.inSeconds >= 1
        ? startCutDuration
        : Duration(seconds: (durVideo.inSeconds-endCutDuration.inSeconds)));
        _records[i].startDuration = offset > _records[i].startDuration ? Duration(seconds: 0) : (_records[i].startDuration - offset);
      }
      isCuttingVideo = false;
      setState(() {});
      saveChanges();
    });
  }



  _resetVideo(){
    Duration durVideo = videoDur;
    setState(() {
      isCuttingVideo = true;
    });
    print('RESET VIDEO');
    if(_controller.dataSource != editorModel!.pathToOriginalVideo){
      File(_controller.dataSource).delete();
    }
    _controller = VideoPlayerController.file(
      File(editorModel!.pathToOriginalVideo)
    );
    _controller.initialize().then((_) async {
      thumnails = [];
      getThumnails();
      videoDur = _controller.value.duration;
      await _controller.play();
      await _controller.pause();
      editorModel!.pathToVideo = editorModel!.pathToOriginalVideo;
      editorModel!.durationVideo = videoDur;
      editorModel!.durationFullTrack = _records.any((element) => element.duration > videoDur) ? editorModel!.durationFullTrack : videoDur;
      editorModel!.endCutDuration = _controller.value.duration;
      editorModel!.startCutDuration = Duration(seconds: 0);
      _controller.addListener(() {
        positionController.sink.add(_controller.value.position.inSeconds);
      });
      isCuttingVideo = false;
      setState(() {});
      saveChanges();
    });
  }


  saveChanges() async{
    editorModel!.records = _records;
    print('RECORDS: ${_records}');
    if(editorModel!.picture == null){
      final String? file = await VideoThumbnail.thumbnailFile(
        imageFormat: ImageFormat.JPEG,
        video: editorModel!.pathToVideo,
        timeMs: 10,
      );
      editorModel!.picture = file;
    }
    if(editorModel!.durationFullTrack == null){
      editorModel!.durationFullTrack = videoDur;
    }
    saveEditorModel(editorModel!);
  }

  @override
  void dispose() {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _allPlayerDispose();
    _controller.removeListener(() { });
    positionController.close();
    timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print('VIDEO DUR: ${videoDur}');
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: Color(0xFF2A2D2F),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  'assets/images/bg.png',
                ).image,
              ),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Align(
                        alignment: AlignmentDirectional(1, -1),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainWidget(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 12, 0),
                                      child: SvgPicture.asset(
                                        'assets/images/Plus.svg',
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'New',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFFDFEFF),
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if(_records.isNotEmpty){
                                    _allPlayerPause();
                                    _exportVideo();
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 12, 0),
                                      child: SvgPicture.asset(
                                        'assets/images/Download.svg',
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Save',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFF39530),
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 58, 0, 0),
                            child: Container(
                              width: double.infinity,
                              // height: 808,
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      _controller.value.isPlaying ? _controller.pause() : _controller.play();
                                    },
                                    child: SizedBox(
                                      height: 272,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          BlurFilter(
                                            child: VideoPlayer(_controller)
                                          ),
                                          AspectRatio(
                                            aspectRatio: _controller.value.aspectRatio,
                                            child: VideoPlayer(_controller)
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if(true)
                                  AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, __) {
                                      final duration = videoDur.inSeconds;
                                      final pos = _controller.value.position;
                                      // final start = _controller.minTrim * duration;
                                      // final end = _controller.maxTrim * duration;

                                      return Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 44, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: _resetVideo,
                                              child: SvgPicture.asset(
                                                'assets/images/reset_video.svg',
                                                height: 26,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 12,),
                                            GestureDetector(
                                              onTap: () {
                                                !_controller.value.isPlaying
                                                    ? _controller.play()
                                                    : _controller.pause();
                                              },
                                              child: SvgPicture.asset(
                                                !_controller.value.isPlaying
                                                    ? 'assets/images/Play.svg'
                                                    : 'assets/images/pause.svg',
                                                width: 32,
                                                height: 32,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                // _controller.isTrimming
                                                    // ? '${formatter(Duration(seconds: start.toInt()))} / ${formatter(Duration(seconds: end.toInt()))}',
                                                    // : 
                                                    '${formatter(Duration(seconds: pos.inSeconds))} / ${formatter(Duration(seconds: duration.toInt()))}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color:
                                                          Color(0xFFFDFEFF),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      lineHeight: 1.2,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  ..._trimSlider(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 16,),
          GestureDetector(
            onTap: (){
              setState(() {
                if(volume == 0){
                  volume = 1;
                }else{
                  volume = 0;
                }
                _controller.setVolume(volume.toDouble());
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 54),
              child: SvgPicture.asset(
                'assets/images/Volume_Down.svg',
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                color: volume == 1 ? Color(0xFFF39530) : null,
              ),
            ),
          ),
          SizedBox(width: 13,),
          if(editorModel != null)
          StreamBuilder<int>(
            stream: positionController.stream,
            builder: (context, snapshot) {
              if(!snapshot.hasData)
              return Container();
              return Expanded(
                child: TimelineEditor(
                  separatorColor: Colors.transparent,
                  timelineTextStyle: TextStyle(color: Colors.transparent),
                  onPositionTap: (s) => position = s,
                  countTracks: 1+_records.length,
                  duration: editorModel!.durationFullTrack,
                  trackBuilder: (track, pps, duration) => track == 0
                  ? TimelineEditorTrack(
                    defaultColor: Colors.transparent,
                    trackHeight: 72,
                    boxes: [
                      TimelineEditorBox(
                        Duration.zero, 
                        videoDur,
                        child: VideoWidget(
                          isCuttingVideo: isCuttingVideo,
                          pps: pps,
                          editorModel: editorModel!,
                          thumbnailsStream: _stream.stream,
                          onCut: _cutVideo,
                          onPositionChange: (seconds){
                            _controller.seekTo(Duration(seconds: seconds));
                          },
                          position: Duration(seconds: snapshot.data ?? 0),
                        )
                        // TrimSlider(
                        //   controller: _controller,
                        //   height: 50,
                        //   child: null,
                        // ),
                        
                      ),
                    ],
                    pixelsPerSeconds: pps,
                    duration: duration,
                  )
                  : getTrackByIndex(track, pps, duration)
                ),
              );
            }
          ),
        ],
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Color(0xFFEF7C00),
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () async {
              _allPlayerPause();
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: AddTrackWidget(),
                  );
                },
              ).then((v){
                setValue(v);
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(48, 0, 0, 0),
                  child: SvgPicture.asset(
                    'assets/images/AddTrack.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(27, 0, 48, 0),
                  child: Text(
                    _records.isEmpty ? 'Add track' : 'Add one more track',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFFFDFEFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  void _exportVideo() async {
    saveChanges();
    _exportingProgress.value = 0;
    _isExporting.value = true;

    exportSecondStep();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // NOTE: To use `-crf 1` and [VideoExportPreset] you need `ffmpeg_kit_flutter_min_gpl` package (with `ffmpeg_kit` only it won't work)
          return LoaderPage(exportingProgress: _exportingProgress);
        },
      ),
    );
  }



  exportSecondStep() async {
    String commandToExec = await generateFFMPEGCommand();
    FFmpegKit.executeAsync(
      commandToExec,
      (file) async {
        _isExporting.value = false;
        if (!mounted) return;
        print('GALLERY SAVER');
        GallerySaver.saveVideo(outputGlobalPath);
        clearCache();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DonePage();
            },
          ),
        );

        setState(() => _exported = true);
        Future.delayed(const Duration(seconds: 2),
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            setState((){
              _exported = false;
            });
          }
        );
      },
      null,
      (stats) {
        double progressValue =
            stats.getTime() / videoDur.inMilliseconds;
        if(progressValue > 50){
          _exportingProgress.value = progressValue;
        }
      }
    );
  }
}



extension Range on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}