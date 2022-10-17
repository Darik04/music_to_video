import '../components/air_drop_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../music_library/music_library_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTrackWidget extends StatefulWidget {
  const AddTrackWidget({Key? key}) : super(key: key);

  @override
  _AddTrackWidgetState createState() => _AddTrackWidgetState();
}

class _AddTrackWidgetState extends State<AddTrackWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Container(
        width: double.infinity,
        height: 273,
        decoration: BoxDecoration(
          color: Color(0x00D9D9D9),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(1, 1),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 200,
                      sigmaY: 200,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0x0FD9D9D9),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 32),
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 65,
                          height: 5,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 302,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(0xFFEF7C00),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicLibraryWidget(),
                            ),
                          ).then((value) => Navigator.pop(context, value));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/ChooseTrack.svg',
                              width: 24,
                              height: 26,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(27, 0, 0, 0),
                              child: Text(
                                'Choose track',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 14, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: AirDropWidget(),
                              );
                            },
                          );
                        },
                        text: 'Import music',
                        icon: Icon(
                          FFIcons.kimport,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          width: 302,
                          height: 56,
                          color: Color(0x00EF7C00),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFDFEFF),
                                    fontWeight: FontWeight.w500,
                                  ),
                          borderSide: BorderSide(
                            color: Color(0xFFFDFEFF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
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
    );
  }
}
