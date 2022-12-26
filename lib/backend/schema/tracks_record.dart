import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'tracks_record.g.dart';

abstract class TracksRecord
    implements Built<TracksRecord, TracksRecordBuilder> {
  static Serializer<TracksRecord> get serializer => _$tracksRecordSerializer;

  @BuiltValueField(wireName: 'track_name')
  String? get trackName;

  @BuiltValueField(wireName: 'category')
  String? get category;

  String? get audio;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(TracksRecordBuilder builder) => builder
    ..trackName = ''
    ..audio = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Tracks');

  static Stream<TracksRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TracksRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  TracksRecord._();
  factory TracksRecord([void Function(TracksRecordBuilder) updates]) =
      _$TracksRecord;

  static TracksRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTracksRecordData({
  String? trackName,
  String? audio,
}) {
  final firestoreData = serializers.toFirestore(
    TracksRecord.serializer,
    TracksRecord(
      (t) => t
        ..trackName = trackName
        ..audio = audio,
    ),
  );

  return firestoreData;
}
