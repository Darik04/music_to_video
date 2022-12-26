import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/composite/apphud_purchase_result.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:music_to_video/config_app.dart';
import 'package:music_to_video/locator.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PreviewPageFourWidget extends StatefulWidget {
  const PreviewPageFourWidget({Key? key}) : super(key: key);

  @override
  _PreviewPageFourWidgetState createState() => _PreviewPageFourWidgetState();
}

class _PreviewPageFourWidgetState extends State<PreviewPageFourWidget> {
  PageController? pageViewController;
  double? ratingBarValue1;
  double? ratingBarValue2;
  double? ratingBarValue3;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  purchase() async{
    ApphudPurchaseResult res = await Apphud.purchase(productId: sl<ConfigApp>().product!.productIdentifier);
    print('RESULT: ${res}');
    print('RESULT: ${res.subscription?.isActive}');
    if(res.subscription != null && res.subscription!.isActive){
      print('COOOLL!');
      sl<ConfigApp>().isSubscribe = true;
      FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      analytics.logPurchase(currency: '${sl<ConfigApp>().product!.priceLocale.currencySymbol}', value: double.parse(sl<ConfigApp>().product!.price));
      Navigator.pop(context);
    }
  }

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
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  'assets/images/bg.png',
                ).image,
              ),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 14, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    // await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => MainWidget(),
                                    //   ),
                                    // );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/close.svg',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(79, 16, 79, 0),
                            child: Container(
                              width: 216,
                              height: 184,
                              decoration: BoxDecoration(),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 216,
                                height: 184,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 38, 16, 0),
                              child: Container(
                                width: 343,
                                height: 120,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          46, 19, 46, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/Sound-orange.svg',
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.contain,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    43, 0, 0, 0),
                                            child: Text(
                                              'Add music to your videos',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          46, 19, 46, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/import-video.svg',
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.contain,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    43, 0, 0, 0),
                                            child: Text(
                                              'Import your tracks',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.normal,
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
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 38, 0, 0),
                    child: Container(
                      width: double.infinity,
                      height: 145,
                      child: Stack(
                        children: [
                          PageView(
                            controller: pageViewController ??=
                                PageController(initialPage: 0),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          RatingBar.builder(
                                            onRatingUpdate: (newValue) =>
                                                setState(() =>
                                                    ratingBarValue1 = newValue),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFB904),
                                            ),
                                            direction: Axis.horizontal,
                                            initialRating: ratingBarValue1 ??=
                                                5,
                                            unratedColor: Color(0xFF9E9E9E),
                                            itemCount: 5,
                                            itemSize: 25,
                                            glowColor: Color(0xFFFFB904),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 24, 0, 0),
                                            child: Text(
                                              'Awesome and simple app to add any music to \nyour videos. I recommend!',
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 16, 0, 0),
                                            child: Text(
                                              'pandasends1',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xB3FDFEFF),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          RatingBar.builder(
                                            onRatingUpdate: (newValue) =>
                                                setState(() =>
                                                    ratingBarValue2 = newValue),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFB904),
                                            ),
                                            direction: Axis.horizontal,
                                            initialRating: ratingBarValue2 ??=
                                                3,
                                            unratedColor: Color(0xFF9E9E9E),
                                            itemCount: 5,
                                            itemSize: 25,
                                            glowColor: Color(0xFFFFB904),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 24, 0, 0),
                                            child: Text(
                                              'Awesome and simple app to add any music to \nyour videos. I recommend!',
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 16, 0, 0),
                                            child: Text(
                                              'pandasends2',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xB3FDFEFF),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          RatingBar.builder(
                                            onRatingUpdate: (newValue) =>
                                                setState(() =>
                                                    ratingBarValue3 = newValue),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFB904),
                                            ),
                                            direction: Axis.horizontal,
                                            initialRating: ratingBarValue3 ??=
                                                4,
                                            unratedColor: Color(0xFF9E9E9E),
                                            itemCount: 5,
                                            itemSize: 25,
                                            glowColor: Color(0xFFFFB904),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 24, 0, 0),
                                            child: Text(
                                              'Awesome and simple app to add any music to \nyour videos. I recommend!',
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 16, 0, 0),
                                            child: Text(
                                              'pandasends3',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xB3FDFEFF),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 1),
                            child: SmoothPageIndicator(
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 3,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) {
                                pageViewController!.animateToPage(
                                  i,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              effect: SlideEffect(
                                spacing: 5,
                                radius: 100,
                                dotWidth: 7,
                                dotHeight: 7,
                                dotColor: Color(0xFF4F5458),
                                activeDotColor: Color(0xFFF39530),
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                        child: Container(
                          width: 343,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xFFEF7C00),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  '1 week',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        lineHeight: 1,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                child: Text(
                                  '\$${sl<ConfigApp>().product == null ? 4.99 : sl<ConfigApp>().product!.price}/week',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        lineHeight: 1,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            purchase();
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => MainWidget(),
                            //   ),
                            // );
                          },
                          text: 'Purchase',
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 7, 0),
                              child: Text(
                                'Restore purchase',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xB3FDFEFF),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 7, 0),
                              child: Text(
                                'Privacy policy',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xB3FDFEFF),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                            Text(
                              'Terms & Conditions',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xB3FDFEFF),
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
