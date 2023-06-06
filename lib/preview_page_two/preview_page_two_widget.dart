// import 'package:in_app_review/in_app_review.dart';
// import 'package:music_to_video/index.dart';

// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
// import '../preview_page_three/preview_page_three_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PreviewPageTwoWidget extends StatefulWidget {
//   const PreviewPageTwoWidget({Key? key}) : super(key: key);

//   @override
//   _PreviewPageTwoWidgetState createState() => _PreviewPageTwoWidgetState();
// }

// class _PreviewPageTwoWidgetState extends State<PreviewPageTwoWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xFF2A2D2F),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 1,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: Image.asset(
//                   'assets/images/bg.png',
//                 ).image,
//               ),
//             ),
//             alignment: AlignmentDirectional(0, 0),
//             child: Align(
//               alignment: AlignmentDirectional(0, 0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       'Choose music from \nlibrary',
//                       textAlign: TextAlign.center,
//                       style: FlutterFlowTheme.of(context).bodyText1.override(
//                             fontFamily: 'Poppins',
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(16, 59, 0, 0),
//                       child: Container(
//                         width: 274,
//                         height: 350,
//                         constraints: BoxConstraints(
//                           maxWidth: 274,
//                           maxHeight: 350,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color(0x00FFFFFF),
//                         ),
//                         child: Image.asset(
//                           'assets/images/Blank-image-2.png',
//                           width: 274,
//                           height: 350,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(16, 98, 16, 0),
//                       child: FFButtonWidget(
//                         onPressed: () async {
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MainWidget(),
//                             ),
//                             (_) => false
//                           );
//                         },
//                         text: 'Continue',
//                         options: FFButtonOptions(
//                           width: 343,
//                           height: 50,
//                           color: Color(0xFFEF7C00),
//                           textStyle:
//                               FlutterFlowTheme.of(context).subtitle2.override(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.white,
//                                   ),
//                           borderSide: BorderSide(
//                             color: Colors.transparent,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
