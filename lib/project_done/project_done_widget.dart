import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDoneWidget extends StatefulWidget {
  const ProjectDoneWidget({Key? key}) : super(key: key);

  @override
  _ProjectDoneWidgetState createState() => _ProjectDoneWidgetState();
}

class _ProjectDoneWidgetState extends State<ProjectDoneWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF2A2D2F),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 308,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset(
                      'assets/images/Done.svg',
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 12),
                      child: Text(
                        'Done',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Text(
                      'The video has been saved to your gllery',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFFF39530),
                            fontWeight: FontWeight.normal,
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
