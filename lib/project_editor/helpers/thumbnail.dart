import 'package:flutter/foundation.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List?> generateThumbnail(String filePath, Duration videoDur, int i) async {
  final String path = filePath;
  final int duration = videoDur.inMilliseconds;
  int _thumbnails = 8;
  final double eachPart = duration / _thumbnails;
  final Uint8List? bytes = await VideoThumbnail.thumbnailData(
    imageFormat: ImageFormat.JPEG,
    video: path,
    timeMs: (eachPart * i).toInt(),
    quality: 2
  );
  return bytes;
}