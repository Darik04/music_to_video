import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AirDropWidget extends StatefulWidget {
  const AirDropWidget({Key? key}) : super(key: key);

  @override
  _AirDropWidgetState createState() => _AirDropWidgetState();
}

class _AirDropWidgetState extends State<AirDropWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Container(
        width: double.infinity,
        height: 253,
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
                    Text(
                      'Import from another device',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: Container(
                        width: 275,
                        height: 50,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SvgPicture.asset(
                              'assets/images/airdrop.svg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                              child: Text(
                                'Use AirDrop to send a track \nto your device',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xB3FDFEFF),
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
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
    );
  }
}
