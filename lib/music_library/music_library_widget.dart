import 'package:audioplayers/audioplayers.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../project_music_adding/project_music_adding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicLibraryWidget extends StatefulWidget {
  const MusicLibraryWidget({Key? key}) : super(key: key);

  @override
  _MusicLibraryWidgetState createState() => _MusicLibraryWidgetState();
}

class _MusicLibraryWidgetState extends State<MusicLibraryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  List<String> categories = [];
  List<TracksRecord> tracks = [];
  
  int selectedCategory = 0;

  refreshData(){
    Future.delayed(Duration(milliseconds: 100),(){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF2A2D2F),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(
                'assets/images/bg.png',
              ).image,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 67, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 22,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 60,
                            height: 100,
                            decoration: BoxDecoration(),
                            child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/Back.svg',
                                    width: 12,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.5, 0, 0, 0),
                                    child: Text(
                                      'Back\n',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFF39530),
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(60, 0, 0, 0),
                            child: Text(
                              'Music library',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 42,
                    decoration: BoxDecoration(),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [

                        ...categories.map((e)
                          => GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedCategory = -1;
                              });
                              Future.delayed(Duration(milliseconds: 100), (){
                                setState(() {
                                  selectedCategory = categories.indexOf(e);
                                });
                              });
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(categories.indexOf(e) == 0 ? 16 : 8, 0, categories.indexOf(e) == (categories.length-1) ? 16 : 0, 0),
                              child: Container(
                                width: 119,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: categories.indexOf(e) == selectedCategory ? Color(0xFFF39530) : Color(0xFFB4B6B7),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      e,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xB22A2D2F),
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ).toList(),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        //   child: Container(
                        //     width: 74,
                        //     height: 42,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xFFF39530),
                        //       borderRadius: BorderRadius.circular(19),
                        //     ),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'Epic',
                        //           style: FlutterFlowTheme.of(context)
                        //               .bodyText1
                        //               .override(
                        //                 fontFamily: 'Poppins',
                        //                 fontSize: 17,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        //   child: Container(
                        //     width: 119,
                        //     height: 42,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xFFB4B6B7),
                        //       borderRadius: BorderRadius.circular(19),
                        //     ),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'Agressive',
                        //           style: FlutterFlowTheme.of(context)
                        //               .bodyText1
                        //               .override(
                        //                 fontFamily: 'Poppins',
                        //                 color: Color(0xB22A2D2F),
                        //                 fontSize: 17,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        //   child: Container(
                        //     width: 75,
                        //     height: 42,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xFFB4B6B7),
                        //       borderRadius: BorderRadius.circular(19),
                        //     ),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'Chill',
                        //           style: FlutterFlowTheme.of(context)
                        //               .bodyText1
                        //               .override(
                        //                 fontFamily: 'Poppins',
                        //                 color: Color(0xB22A2D2F),
                        //                 fontSize: 17,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        //   child: Container(
                        //     width: 90,
                        //     height: 42,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xFFB4B6B7),
                        //       borderRadius: BorderRadius.circular(19),
                        //     ),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'Funny',
                        //           style: FlutterFlowTheme.of(context)
                        //               .bodyText1
                        //               .override(
                        //                 fontFamily: 'Poppins',
                        //                 color: Color(0xB22A2D2F),
                        //                 fontSize: 17,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(8, 0, 16, 0),
                        //   child: Container(
                        //     width: 119,
                        //     height: 42,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xFFB4B6B7),
                        //       borderRadius: BorderRadius.circular(19),
                        //     ),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'Agressive',
                        //           style: FlutterFlowTheme.of(context)
                        //               .bodyText1
                        //               .override(
                        //                 fontFamily: 'Poppins',
                        //                 color: Color(0xB22A2D2F),
                        //                 fontSize: 17,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: StreamBuilder<List<TracksRecord>>(
                        stream: queryTracksRecord(),
                        builder: (context, snapshot) {
                          print('DATA GOT');
                          if(categories.isEmpty && snapshot.hasData){
                            tracks = snapshot.data!;
                            for(var track in tracks){
                              if(track.category != null && track.category != '' && !categories.contains(track.category)){
                                categories.add(track.category!);
                              }
                            }
                            refreshData();
                          }
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          List<TracksRecord> listViewTracksRecordList = selectedCategory == -1 ? [] : tracks.where((element) => element.category == categories[selectedCategory]).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewTracksRecordList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewTracksRecord =
                                  listViewTracksRecordList[listViewIndex];
                              return TrackWidget(
                                listViewTracksRecord: listViewTracksRecord,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrackWidget extends StatefulWidget {
  const TrackWidget({
    Key? key,
    required this.listViewTracksRecord,
  }) : super(key: key);

  final TracksRecord listViewTracksRecord;

  @override
  State<TrackWidget> createState() => _TrackWidgetState();
}

class _TrackWidgetState extends State<TrackWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    setDuration();
    super.initState();
  }

  void setDuration() async {
    await _audioPlayer.setSource(UrlSource(widget.listViewTracksRecord.audio!));
    _audioPlayer.onPlayerStateChanged.listen((state) {
        _isPlaying = state == PlayerState.playing;
    });
    duration = (await _audioPlayer.getDuration())!;
    setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
      child: Container(
        width: double.infinity,
        height: 69,
        decoration: BoxDecoration(
          color: Color(0x1AD9D9D9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (!_isPlaying) {
                        await _audioPlayer.play(
                            UrlSource(widget.listViewTracksRecord.audio!));
                      } else {
                        await _audioPlayer.pause();
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 149, 48, 1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(34, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                          child: Text(
                            widget.listViewTracksRecord.trackName!,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            duration.inSeconds == 0 ? 'Loading' : duration.toString().substring(0, 7),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FFButtonWidget(
                onPressed: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProjectMusicAddingWidget(),
                  //   ),
                  // );
                  Navigator.pop(context, widget.listViewTracksRecord);
                },
                text: 'Choose',
                options: FFButtonOptions(
                  width: 85,
                  height: 37,
                  color: Color(0x00F39530),
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15,
                      ),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
