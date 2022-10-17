// import '../components/create_project_widget.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
// import '../project_editor/project_editor_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MainNewProjectWidget extends StatefulWidget {
//   const MainNewProjectWidget({Key? key}) : super(key: key);

//   @override
//   _MainNewProjectWidgetState createState() => _MainNewProjectWidgetState();
// }

// class _MainNewProjectWidgetState extends State<MainNewProjectWidget> {
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
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Image.asset(
//                     'assets/images/logo.png',
//                     width: 182,
//                     height: 155,
//                     fit: BoxFit.contain,
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(18, 102, 18, 0),
//                     child: Text(
//                       'Recent Projects',
//                       style: FlutterFlowTheme.of(context).bodyText1.override(
//                             fontFamily: 'Poppins',
//                             color: Color(0xFFFDFEFF),
//                             fontSize: 22,
//                             fontWeight: FontWeight.w500,
//                           ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
//                     child: Container(
//                       width: 100,
//                       height: 80,
//                       decoration: BoxDecoration(),
//                       child: ListView(
//                         padding: EdgeInsets.zero,
//                         primary: false,
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
//                             child: InkWell(
//                               onTap: () async {
//                                 await Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ProjectEditorWidget(),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 width: 80,
//                                 height: 80,
//                                 decoration: BoxDecoration(),
//                                 child: Image.asset(
//                                   'assets/images/Progect-image.png',
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(),
//                               child: SvgPicture.asset(
//                                 'assets/images/AddProject.svg',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(),
//                               child: SvgPicture.asset(
//                                 'assets/images/Rectangle_6.svg',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(),
//                               child: SvgPicture.asset(
//                                 'assets/images/Rectangle_6.svg',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(),
//                               child: SvgPicture.asset(
//                                 'assets/images/Rectangle_6.svg',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 0, 18, 0),
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(),
//                               child: SvgPicture.asset(
//                                 'assets/images/Rectangle_6.svg',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(0, 0),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
//                       child: FFButtonWidget(
//                         onPressed: () async {
//                           await showModalBottomSheet(
//                             isScrollControlled: true,
//                             backgroundColor: Colors.transparent,
//                             context: context,
//                             builder: (context) {
//                               return Padding(
//                                 padding: MediaQuery.of(context).viewInsets,
//                                 child: Container(
//                                   height: 303,
//                                   child: null, //CreateProjectWidget(),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         text: 'New Project',
//                         options: FFButtonOptions(
//                           width: 267,
//                           height: 57,
//                           color: Color(0xFFEF7C00),
//                           textStyle:
//                               FlutterFlowTheme.of(context).subtitle2.override(
//                                     fontFamily: 'Poppins',
//                                     color: Color(0xFFFDFEFF),
//                                     fontSize: 22,
//                                     letterSpacing: 0.5,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                           borderSide: BorderSide(
//                             color: Colors.transparent,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
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
