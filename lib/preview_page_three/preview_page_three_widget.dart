import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../preview_page_four/preview_page_four_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewPageThreeWidget extends StatefulWidget {
  const PreviewPageThreeWidget({Key? key}) : super(key: key);

  @override
  _PreviewPageThreeWidgetState createState() => _PreviewPageThreeWidgetState();
}

class _PreviewPageThreeWidgetState extends State<PreviewPageThreeWidget> {
  double? ratingBarValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF2A2D2F),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  'assets/images/bg.png',
                ).image,
              ),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Please rate\nthe App!',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'We always apreciate your feedback\nto make our products better',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xB2FDFEFF),
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 39, 0, 0),
                        child: Container(
                          width: 301,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Color(0xFF26292A),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 14,
                                color: Color(0x26000000),
                                offset: Offset(6, 6),
                                spreadRadius: 0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                child: Container(
                                  width: 73,
                                  height: 73,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Color(0x08000000),
                                        offset: Offset(-6, -6),
                                        spreadRadius: 0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 14,
                                          color: Color(0x26000000),
                                          offset: Offset(6, 6),
                                          spreadRadius: 0,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Image.asset(
                                      'assets/images/Avatar-Review.png',
                                      width: 73,
                                      height: 73,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              RatingBar.builder(
                                onRatingUpdate: (newValue) =>
                                    setState(() => ratingBarValue = newValue),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFFB904),
                                ),
                                direction: Axis.horizontal,
                                initialRating: ratingBarValue ??= 5,
                                unratedColor: Color(0xFF9E9E9E),
                                itemCount: 5,
                                itemPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                itemSize: 25,
                                glowColor: Color(0xFFFFB904),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: Text(
                                  'Amazing product',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                                child: Text(
                                  'I made a lot of cool videos\nusing this app.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xE6FDFEFF),
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 123, 16, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreviewPageFourWidget(),
                            ),
                          );
                        },
                        text: 'Continue',
                        options: FFButtonOptions(
                          width: 343,
                          height: 50,
                          color: Color(0xFFEF7C00),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
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
}
