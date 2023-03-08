// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  bool get isTransacting => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  bool get isSent => throw _privateConstructorUsedError;
  bool get isSendActive => throw _privateConstructorUsedError;
  bool get isRecentsActive => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {bool isTransacting,
      bool isSending,
      bool isSent,
      bool isSendActive,
      bool isRecentsActive});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTransacting = null,
    Object? isSending = null,
    Object? isSent = null,
    Object? isSendActive = null,
    Object? isRecentsActive = null,
  }) {
    return _then(_value.copyWith(
      isTransacting: null == isTransacting
          ? _value.isTransacting
          : isTransacting // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isSendActive: null == isSendActive
          ? _value.isSendActive
          : isSendActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecentsActive: null == isRecentsActive
          ? _value.isRecentsActive
          : isRecentsActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isTransacting,
      bool isSending,
      bool isSent,
      bool isSendActive,
      bool isRecentsActive});
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppState>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTransacting = null,
    Object? isSending = null,
    Object? isSent = null,
    Object? isSendActive = null,
    Object? isRecentsActive = null,
  }) {
    return _then(_$_AppState(
      isTransacting: null == isTransacting
          ? _value.isTransacting
          : isTransacting // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isSendActive: null == isSendActive
          ? _value.isSendActive
          : isSendActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecentsActive: null == isRecentsActive
          ? _value.isRecentsActive
          : isRecentsActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AppState implements _AppState {
  const _$_AppState(
      {required this.isTransacting,
      required this.isSending,
      required this.isSent,
      required this.isSendActive,
      required this.isRecentsActive});

  @override
  final bool isTransacting;
  @override
  final bool isSending;
  @override
  final bool isSent;
  @override
  final bool isSendActive;
  @override
  final bool isRecentsActive;

  @override
  String toString() {
    return 'AppState(isTransacting: $isTransacting, isSending: $isSending, isSent: $isSent, isSendActive: $isSendActive, isRecentsActive: $isRecentsActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            (identical(other.isTransacting, isTransacting) ||
                other.isTransacting == isTransacting) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isSent, isSent) || other.isSent == isSent) &&
            (identical(other.isSendActive, isSendActive) ||
                other.isSendActive == isSendActive) &&
            (identical(other.isRecentsActive, isRecentsActive) ||
                other.isRecentsActive == isRecentsActive));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isTransacting, isSending, isSent,
      isSendActive, isRecentsActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {required final bool isTransacting,
      required final bool isSending,
      required final bool isSent,
      required final bool isSendActive,
      required final bool isRecentsActive}) = _$_AppState;

  @override
  bool get isTransacting;
  @override
  bool get isSending;
  @override
  bool get isSent;
  @override
  bool get isSendActive;
  @override
  bool get isRecentsActive;
  @override
  @JsonKey(ignore: true)
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
