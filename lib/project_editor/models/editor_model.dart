import 'package:music_to_video/project_editor/models/audio_model.dart';

class EditorModel{
  String editorCode;
  Duration durationVideo;
  Duration? durationFullTrack;
  Duration startCutDuration;
  Duration endCutDuration;
  String? picture;
  String pathToVideo;
  String pathToOriginalVideo;
  List<AudioModel> records;

  EditorModel({
    required this.editorCode,
    required this.durationVideo,
    required this.durationFullTrack,
    required this.pathToVideo,
    required this.pathToOriginalVideo,
    required this.records,
    required this.startCutDuration,
    required this.endCutDuration,
    required this.picture
  });



  factory EditorModel.fromJson(Map<String, dynamic> json) => EditorModel(
    editorCode: json['editor_code'],
    picture: json['picture'],
    durationFullTrack: json['duration_full'] != null ? Duration(seconds: json['duration_full'] ?? 0) : Duration(seconds: json['duration'] ?? 0),
    durationVideo: Duration(seconds: json['duration'] ?? 0),
    startCutDuration: Duration(seconds: 0),
    endCutDuration: Duration(seconds: json['duration'] ?? 0),
    pathToVideo: json['path_to_video'],
    pathToOriginalVideo: json['path_to_original_video'] ?? json['path_to_video'],
    records: json['records'] == null 
    ? []
    : (json['records'] as List).map((json) => AudioModel.fromJson(json)).toList()
  );



  Map<String, dynamic> toJson() {
    return {
      'editor_code': editorCode,
      'picture': picture,
      'duration': durationVideo.inSeconds,
      'duration_full': durationFullTrack == null ? null : durationFullTrack!.inSeconds,
      'path_to_video': pathToVideo,
      'path_to_original_video': pathToOriginalVideo,
      'records': records.map((e) => e.toJson()).toList()
    };
  }
}