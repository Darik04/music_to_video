// import 'package:music_to_video/preview_page_three/preview_page_three_widget.dart';

// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
// import '../preview_page_two/preview_page_two_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PreviewPageWidget extends StatefulWidget {
//   const PreviewPageWidget({Key? key}) : super(key: key);

//   @override
//   _PreviewPageWidgetState createState() => _PreviewPageWidgetState();
// }

// class _PreviewPageWidgetState extends State<PreviewPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xFF2A2D2F),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height * 1,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: Image.asset(
//                 'assets/images/bg.png',
//               ).image,
//             ),
//           ),
//           alignment: AlignmentDirectional(0, 0),
//           child: Align(
//             alignment: AlignmentDirectional(0, 0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Add music\nto your videos',
//                     textAlign: TextAlign.center,
//                     style: FlutterFlowTheme.of(context).bodyText1.override(
//                           fontFamily: 'Poppins',
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
//                     child: Text(
//                       'Make your videos amusing \nin two taps',
//                       textAlign: TextAlign.center,
//                       style: FlutterFlowTheme.of(context).bodyText1.override(
//                             fontFamily: 'Poppins',
//                             color: Color(0xB2FDFEFF),
//                             fontWeight: FontWeight.normal,
//                           ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(16, 39, 0, 0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0x00FFFFFF),
//                       ),
//                       child: Image.asset(
//                         'assets/images/Preview-1.png',
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(16, 66, 16, 0),
//                     child: FFButtonWidget(
//                       onPressed: () async {
//                         await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PreviewPageThreeWidget(),
//                           ),
//                         );
//                       },
//                       text: 'Continue',
//                       options: FFButtonOptions(
//                         width: 343,
//                         height: 50,
//                         color: Color(0xFFEF7C00),
//                         textStyle:
//                             FlutterFlowTheme.of(context).subtitle2.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                 ),
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
