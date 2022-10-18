import 'dart:io';
import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit_config.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';

Future<String> downloadFile(String url, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';
  print('AUDIO URL: ${url}');

  try {
    myUrl = url;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();
    if(response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      final int epoch = DateTime.now().millisecondsSinceEpoch;
      
      filePath = '$dir/VID_$epoch.mp3';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    }
    else
      filePath = 'Error code: '+response.statusCode.toString();
  }
  catch(ex){
    filePath = 'Can not fetch url';
  }
  print('FILE PATH: ${filePath}');
  return filePath;
}



Future<String> cutAudio(String pathToAudio, Duration startDuration, Duration duration) async {
  String command = '-i \'${pathToAudio}\' -ss 0${startDuration.toString().substring(0, 7)}  -t 0${duration.toString().substring(0, 7)}';
  final String tempPath = (await getTemporaryDirectory()).path;
  final int epoch = DateTime.now().millisecondsSinceEpoch;
  final String outputPath = "$tempPath/AUD_$epoch.mp3";
  command += ' -c copy $outputPath';
  print('COMMAND AUD: ${command}');
  var session = await FFmpegKit.execute(command);
  final state =
      FFmpegKitConfig.sessionStateToString(await session.getState());
  final code = await session.getReturnCode();
  if (code?.isValueSuccess() == true) {
    return outputPath;
  }else {
    throw 'FFmpeg process exited with state $state and return code $code.\n${await session.getOutput()}';
  }
}


Future<String> mergeAudio(String v, String pathToAudio1,String pathToAudio2, Duration startAudio1, Duration startAudio2, Duration videoDur, {bool muteAudio1 = false}) async {
  String command = '-i \'$v\' -ss 00:00:00  -t 0${videoDur.toString().substring(0, 7)} -i \'$pathToAudio1\'';
  command += ' -i \'$pathToAudio2\'';
  // command += ' -ss 00:00:00 -t 0${videoDur.toString().substring(0, 7)}';
  command += ' -f lavfi -i anullsrc -filter_complex \"${muteAudio1 ? '' : '[1:a]adelay=${startAudio1.inMilliseconds}:all=1[c1];'}[2:a]adelay=${startAudio2.inMilliseconds}:all=1[c2];${muteAudio1 ? '' : '[c1]'}[c2]amix=inputs=${muteAudio1 ? '1' : '2'}[aout]\"';
  final String tempPath = (await getTemporaryDirectory()).path;
  final int epoch = DateTime.now().millisecondsSinceEpoch;
  final String outputPath = "$tempPath/AUD_$epoch.mp4";
    // command += ' -map 0:a -map 1:a';
  command += ' -map [aout] $outputPath';
  print('COMMAND AUD MERGE: ${command}');
  var session = await FFmpegKit.execute(command);
  final state =
      FFmpegKitConfig.sessionStateToString(await session.getState());
  final code = await session.getReturnCode();
  if (code?.isValueSuccess() == true) {
    return outputPath;
  }else {
    throw 'FFmpeg process exited with state $state and return code $code.\n${await session.getOutput()}';
  }
}




Future<String> cutVideo(String path, Duration startDuration, Duration duration) async {
  String command = '-i \'${path}\' -ss 0${startDuration.toString().substring(0, 7)}  -t 0${duration.toString().substring(0, 7)}';
  final String tempPath = (await getTemporaryDirectory()).path;
  final int epoch = DateTime.now().millisecondsSinceEpoch;
  final String outputPath = "$tempPath/VID_$epoch.mp4";
  command += ' -c copy $outputPath';
  print('COMMAND VID: ${command}');
  var session = await FFmpegKit.execute(command);
  final state =
      FFmpegKitConfig.sessionStateToString(await session.getState());
  final code = await session.getReturnCode();
  if (code?.isValueSuccess() == true) {
    return outputPath;
  }else {
    throw 'FFmpeg process exited with state $state and return code $code.\n${await session.getOutput()}';
  }
}