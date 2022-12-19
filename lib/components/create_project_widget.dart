import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:music_to_video/project_editor/project_editor_widget.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProjectWidget extends StatefulWidget {
  const CreateProjectWidget(
    this.docProject, {
    Key? key,
  }) : super(key: key);

  final ProjectsRecord? docProject;

  @override
  _CreateProjectWidgetState createState() => _CreateProjectWidgetState();
}

class _CreateProjectWidgetState extends State<CreateProjectWidget> {
  String uploadedFileUrl1 = '';
  TextEditingController? textController;
  String uploadedFileUrl2 = '';

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  //Pick from source(phone)
  void _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (mounted && file != null) {
      navigate(File(file.path));
    }
  }



  //Pick from camera
  void _recordVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.camera);
    if(file != null){
      navigate(File(file.path));
    }
  }

  void navigate(File file){
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ProjectEditorWidget(
            file: File(file.path),
            editorModel: null,
          )
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
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
              Column(
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
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter the project name',
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyText2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
                    ),
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        _pickVideo();
                        // final selectedMedia = await selectMedia(
                        //   isVideo: true,
                        //   mediaSource: MediaSource.videoGallery,
                        //   multiImage: false,
                        // );
                        // if (selectedMedia != null &&
                        //     selectedMedia.every((m) =>
                        //         validateFileFormat(m.storagePath, context))) {
                        //   showUploadMessage(
                        //     context,
                        //     'Uploading file...',
                        //     showLoading: true,
                        //   );
                        //   final downloadUrls = (await Future.wait(selectedMedia
                        //           .map((m) async => await uploadData(
                        //               m.storagePath, m.bytes))))
                        //       .where((u) => u != null)
                        //       .map((u) => u!)
                        //       .toList();
                        //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        //   if (downloadUrls.length == selectedMedia.length) {
                        //     setState(
                        //         () => uploadedFileUrl1 = downloadUrls.first);
                        //     showUploadMessage(
                        //       context,
                        //       'Success!',
                        //     );
                        //   } else {
                        //     showUploadMessage(
                        //       context,
                        //       'Failed to upload media',
                        //     );
                        //     return;
                        //   }
                        // }

                        // final projectsCreateData = createProjectsRecordData(
                        //   name: textController!.text,
                        //   video: uploadedFileUrl1,
                        // );
                        // await ProjectsRecord.collection
                        //     .doc()
                        //     .set(projectsCreateData);
                        // Navigator.pop(context);
                      },
                      text: 'Choose from gallery',
                      icon: Icon(
                        FFIcons.kfolder,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        width: 302,
                        height: 56,
                        color: Color(0xFFEF7C00),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFFDFEFF),
                                  fontWeight: FontWeight.w500,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: FFButtonWidget(
                      onPressed: _recordVideo,
                      text: 'Record new video',
                      icon: Icon(
                        FFIcons.kvideo,
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
            ],
          ),
        ),
      ),
    );
  }
}
