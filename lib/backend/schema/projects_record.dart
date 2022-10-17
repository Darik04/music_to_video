import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'projects_record.g.dart';

abstract class ProjectsRecord
    implements Built<ProjectsRecord, ProjectsRecordBuilder> {
  static Serializer<ProjectsRecord> get serializer =>
      _$projectsRecordSerializer;

  @BuiltValueField(wireName: 'Name')
  String? get name;

  @BuiltValueField(wireName: 'Video')
  String? get video;

  @BuiltValueField(wireName: 'Audio')
  BuiltList<String>? get audio;

  String? get photoPreview;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ProjectsRecordBuilder builder) => builder
    ..name = ''
    ..video = ''
    ..audio = ListBuilder()
    ..photoPreview = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('projects');

  static Stream<ProjectsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ProjectsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ProjectsRecord._();
  factory ProjectsRecord([void Function(ProjectsRecordBuilder) updates]) =
      _$ProjectsRecord;

  static ProjectsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createProjectsRecordData({
  String? name,
  String? video,
  String? photoPreview,
}) {
  final firestoreData = serializers.toFirestore(
    ProjectsRecord.serializer,
    ProjectsRecord(
      (p) => p
        ..name = name
        ..video = video
        ..audio = null
        ..photoPreview = photoPreview,
    ),
  );

  return firestoreData;
}
