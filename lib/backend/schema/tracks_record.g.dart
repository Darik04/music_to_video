// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TracksRecord> _$tracksRecordSerializer =
    new _$TracksRecordSerializer();

class _$TracksRecordSerializer implements StructuredSerializer<TracksRecord> {
  @override
  final Iterable<Type> types = const [TracksRecord, _$TracksRecord];
  @override
  final String wireName = 'TracksRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, TracksRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.trackName;
    if (value != null) {
      result
        ..add('track_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.audio;
    if (value != null) {
      result
        ..add('audio')
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
  TracksRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TracksRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'track_name':
          result.trackName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'audio':
          result.audio = serializers.deserialize(value,
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

class _$TracksRecord extends TracksRecord {
  @override
  final String? trackName;
  @override
  final String? category;
  @override
  final String? audio;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$TracksRecord([void Function(TracksRecordBuilder)? updates]) =>
      (new TracksRecordBuilder()..update(updates))._build();

  _$TracksRecord._({this.trackName, this.category, this.audio, this.ffRef})
      : super._();

  @override
  TracksRecord rebuild(void Function(TracksRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TracksRecordBuilder toBuilder() => new TracksRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TracksRecord &&
        trackName == other.trackName &&
        category == other.category &&
        audio == other.audio &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, trackName.hashCode), category.hashCode), audio.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TracksRecord')
          ..add('trackName', trackName)
          ..add('category', category)
          ..add('audio', audio)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class TracksRecordBuilder
    implements Builder<TracksRecord, TracksRecordBuilder> {
  _$TracksRecord? _$v;

  String? _trackName;
  String? get trackName => _$this._trackName;
  set trackName(String? trackName) => _$this._trackName = trackName;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _audio;
  String? get audio => _$this._audio;
  set audio(String? audio) => _$this._audio = audio;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  TracksRecordBuilder() {
    TracksRecord._initializeBuilder(this);
  }

  TracksRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _trackName = $v.trackName;
      _category = $v.category;
      _audio = $v.audio;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TracksRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TracksRecord;
  }

  @override
  void update(void Function(TracksRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TracksRecord build() => _build();

  _$TracksRecord _build() {
    final _$result = _$v ??
        new _$TracksRecord._(
            trackName: trackName,
            category: category,
            audio: audio,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
