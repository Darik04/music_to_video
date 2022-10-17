import 'package:music_to_video/project_editor/models/audio_model.dart';

class EditorModel{
  String editorCode;
  Duration durationVideo;
  Duration startCutDuration;
  Duration endCutDuration;
  String? picture;
  final String pathToVideo;
  List<AudioModel> records;

  EditorModel({
    required this.editorCode,
    required this.durationVideo,
    required this.pathToVideo,
    required this.records,
    required this.startCutDuration,
    required this.endCutDuration,
    required this.picture
  });



  factory EditorModel.fromJson(Map<String, dynamic> json) => EditorModel(
    editorCode: json['editor_code'],
    picture: json['picture'],
    durationVideo: Duration(seconds: json['duration'] ?? 0),
    startCutDuration: Duration(seconds: 0),
    endCutDuration: Duration(seconds: json['duration'] ?? 0),
    pathToVideo: json['path_to_video'],
    records: json['records'] == null 
    ? []
    : (json['records'] as List).map((json) => AudioModel.fromJson(json)).toList()
  );



  Map<String, dynamic> toJson() {
    return {
      'editor_code': editorCode,
      'picture': picture,
      'duration': durationVideo.inSeconds,
      'path_to_video': pathToVideo,
      'records': records.map((e) => e.toJson()).toList()
    };
  }
}