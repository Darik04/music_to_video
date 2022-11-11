import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_to_video/flutter_flow/flutter_flow_theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';




class LoaderPage extends StatelessWidget {
  final ValueNotifier<double> exportingProgress;
  LoaderPage({required this.exportingProgress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'assets/images/Processing.svg',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, 44, 0, 12),
                      child: Text(
                        'Processing...',
                        style: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(23, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: exportingProgress,
                            builder: (_, double value, __) => Text(
                              "${(value * 100).ceil()}%",
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFDFEFF),
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: exportingProgress,
                      builder: (_, double value, __) =>
                          LinearPercentIndicator(
                        percent: value,
                        width: 300,
                        lineHeight: 8,
                        animation: false,
                        progressColor: Color(0xFFF39530),
                        backgroundColor: Color(0xB2F1F4F8),
                        barRadius: Radius.circular(10),
                        padding: EdgeInsets.zero,
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