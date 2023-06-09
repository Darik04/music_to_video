import 'dart:io';

import 'package:music_to_video/config_app.dart';
import 'package:music_to_video/preview_page_four/preview_page_four_widget.dart';
import 'package:music_to_video/project_editor/models/editor_model.dart';
import 'package:music_to_video/project_editor/provider/provider.dart';
import 'package:provider/provider.dart';

import '../backend/backend.dart';
import '../components/create_project_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../locator.dart';
import '../project_editor/helpers/editor_cache.dart';
import '../project_editor/project_editor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MainProvider>(context, listen: false).fetchData();

  }

  refreshData() async {
    // state.editors = await getEditorModels();
    // setState(() {});
    Future.delayed(Duration(milliseconds: 1500), (){
      Provider.of<MainProvider>(context, listen: false).fetchData();
    });
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _imageProjectsRecordSingleBack;

  showShowModalNewProject() async{
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              MediaQuery.of(context).viewInsets,
          child: Container(
            height: 303+MediaQuery.of(context).padding.top,
            child: CreateProjectWidget(
              _imageProjectsRecordSingleBack,
            ),
          ),
        );
      },
    );
  }


  // chechFirstOpen(){
  //   if(sl<ConfigApp>().firstOpen){
  //     print('FIRST: OPEN PAYWALL');
  //     sl<ConfigApp>().firstOpen = false;
  //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PreviewPageFourWidget()));
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => chechFirstOpen());
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF2A2D2F),
      body: Consumer<MainProvider>(
        builder: (context, state, child) {
          return GestureDetector(
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
                  child: Align(
                    alignment: AlignmentDirectional(0, 0.05),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 182,
                          height: 155,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(18, 102, 18, 0),
                          child: Text(
                            'Recent Projects',
                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFFDFEFF),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
                          child: Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.editors.length,
                                      itemBuilder: (context, listViewIndex) {
                                        return Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 0, 0),
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            alignment: AlignmentDirectional(0, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                // if(!sl<ConfigApp>().isSubscribe){
                                                //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PreviewPageFourWidget()));
                                                // }else{
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProjectEditorWidget(
                                                          editorModel: state.editors[listViewIndex],
                                                      ),
                                                    ),
                                                  );
                                                  print('SAVED: ${state.editors}');
                                                  setState(() {});
                                                  refreshData();
                                                // }
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.file(
                                                  File(state.editors[listViewIndex].picture ?? ''),
                                                  errorBuilder: (context, error, stackTrace) 
                                                    => Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black38,
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Icon(
                                                        Icons.camera_alt_outlined,
                                                        color: Colors.white,
                                                      )
                                                    ),
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          // if(!sl<ConfigApp>().isSubscribe){
                                          //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PreviewPageFourWidget()));
                                          // }else{
                                            await showShowModalNewProject();
                                            refreshData();
                                          // }
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: SvgPicture.asset(
                                            'assets/images/AddProject.svg',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),


                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 3,
                                      itemBuilder: (context, listViewIndex) {
                                        return Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 0, 0),
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            alignment: AlignmentDirectional(0, 0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: SvgPicture.asset(
                                                'assets/images/empty_project.svg',
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                // if(!sl<ConfigApp>().isSubscribe){
                                //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PreviewPageFourWidget()));
                                // }else{
                                  await showShowModalNewProject();
                                  refreshData();
                                // }
                              },
                              text: 'New Project',
                              options: FFButtonOptions(
                                width: 267,
                                height: 57,
                                color: Color(0xFFEF7C00),
                                textStyle:
                                    FlutterFlowTheme.of(context).subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFFFDFEFF),
                                          fontSize: 22,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }
}
