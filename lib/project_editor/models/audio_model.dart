import 'package:audioplayers/audioplayers.dart';

class AudioModel{
  Duration duration;
  Duration durationDefault;
  Duration startDuration;
  Duration startCutDuration;
  Duration endCutDuration;
  Duration startCutDurationForExport;
  Duration endCutDurationForExport;
  final String urlToAudio;
  final String pathToAudio;
  String pathToAudioCutted;
  final String? trackName;
  AudioPlayer audioPlayer;

  AudioModel({
    required this.duration,
    required this.durationDefault,
    required this.audioPlayer,
    required this.startDuration,
    required this.startCutDuration,
    required this.endCutDuration,
    required this.startCutDurationForExport,
    required this.endCutDurationForExport,
    required this.urlToAudio,
    required this.pathToAudio,
    required this.pathToAudioCutted,
    required this.trackName
  });


  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
    audioPlayer: AudioPlayer(),
    durationDefault: Duration(seconds: json['duration_default'] ?? 0),
    duration: Duration(seconds: json['duration'] ?? 0),
    startDuration: Duration(seconds: json['start_duration'] ?? 0),
    startCutDuration: Duration(seconds: json['start_cut_duration'] ?? 0),
    endCutDuration: Duration(seconds: json['end_cut_duration'] ?? 0),
    startCutDurationForExport: Duration(seconds: json['start_cut_duration_for_export'] ?? 0),
    endCutDurationForExport: Duration(seconds: json['end_cut_duration_for_export'] ?? 0),
    urlToAudio: json['url_to_audio'],
    pathToAudio: json['path_to_audio'],
    pathToAudioCutted: json['path_to_audio_cutted'],
    trackName: json['track_name']
  );



  Map<String, dynamic> toJson() {
    return {
      'duration': duration.inSeconds,
      'duration_default': durationDefault.inSeconds,
      'start_duration': startDuration.inSeconds,
      'start_cut_duration': startCutDuration.inSeconds,
      'end_cut_duration': endCutDuration.inSeconds,
      'start_cut_duration_for_export': startCutDurationForExport.inSeconds,
      'end_cut_duration_for_export': endCutDurationForExport.inSeconds,
      'url_to_audio': urlToAudio,
      'path_to_audio': pathToAudio,
      'path_to_audio_cutted': pathToAudioCutted,
      'track_name': trackName,
    };
  }
}