// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectsRecord> _$projectsRecordSerializer =
    new _$ProjectsRecordSerializer();

class _$ProjectsRecordSerializer
    implements StructuredSerializer<ProjectsRecord> {
  @override
  final Iterable<Type> types = const [ProjectsRecord, _$ProjectsRecord];
  @override
  final String wireName = 'ProjectsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProjectsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('Name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.video;
    if (value != null) {
      result
        ..add('Video')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.audio;
    if (value != null) {
      result
        ..add('Audio')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.photoPreview;
    if (value != null) {
      result
        ..add('photoPreview')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  ProjectsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'Name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Video':
          result.video = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Audio':
          result.audio.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'photoPreview':
          result.photoPreview = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectsRecord extends ProjectsRecord {
  @override
  final String? name;
  @override
  final String? video;
  @override
  final BuiltList<String>? audio;
  @override
  final String? photoPreview;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ProjectsRecord([void Function(ProjectsRecordBuilder)? updates]) =>
      (new ProjectsRecordBuilder()..update(updates))._build();

  _$ProjectsRecord._(
      {this.name, this.video, this.audio, this.photoPreview, this.ffRef})
      : super._();

  @override
  ProjectsRecord rebuild(void Function(ProjectsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectsRecordBuilder toBuilder() =>
      new ProjectsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectsRecord &&
        name == other.name &&
        video == other.video &&
        audio == other.audio &&
        photoPreview == other.photoPreview &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, name.hashCode), video.hashCode), audio.hashCode),
            photoPreview.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectsRecord')
          ..add('name', name)
          ..add('video', video)
          ..add('audio', audio)
          ..add('photoPreview', photoPreview)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ProjectsRecordBuilder
    implements Builder<ProjectsRecord, ProjectsRecordBuilder> {
  _$ProjectsRecord? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _video;
  String? get video => _$this._video;
  set video(String? video) => _$this._video = video;

  ListBuilder<String>? _audio;
  ListBuilder<String> get audio => _$this._audio ??= new ListBuilder<String>();
  set audio(ListBuilder<String>? audio) => _$this._audio = audio;

  String? _photoPreview;
  String? get photoPreview => _$this._photoPreview;
  set photoPreview(String? photoPreview) => _$this._photoPreview = photoPreview;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ProjectsRecordBuilder() {
    ProjectsRecord._initializeBuilder(this);
  }

  ProjectsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _video = $v.video;
      _audio = $v.audio?.toBuilder();
      _photoPreview = $v.photoPreview;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectsRecord;
  }

  @override
  void update(void Function(ProjectsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectsRecord build() => _build();

  _$ProjectsRecord _build() {
    _$ProjectsRecord _$result;
    try {
      _$result = _$v ??
          new _$ProjectsRecord._(
              name: name,
              video: video,
              audio: _audio?.build(),
              photoPreview: photoPreview,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'audio';
        _audio?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProjectsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
