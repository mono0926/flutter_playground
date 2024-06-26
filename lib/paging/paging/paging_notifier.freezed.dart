// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PagingState<T> {
  bool get hasMore => throw _privateConstructorUsedError;
  List<QueryDocumentSnapshot<T>> get snapshots =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PagingStateCopyWith<T, PagingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingStateCopyWith<T, $Res> {
  factory $PagingStateCopyWith(
          PagingState<T> value, $Res Function(PagingState<T>) then) =
      _$PagingStateCopyWithImpl<T, $Res, PagingState<T>>;
  @useResult
  $Res call({bool hasMore, List<QueryDocumentSnapshot<T>> snapshots});
}

/// @nodoc
class _$PagingStateCopyWithImpl<T, $Res, $Val extends PagingState<T>>
    implements $PagingStateCopyWith<T, $Res> {
  _$PagingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasMore = null,
    Object? snapshots = null,
  }) {
    return _then(_value.copyWith(
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      snapshots: null == snapshots
          ? _value.snapshots
          : snapshots // ignore: cast_nullable_to_non_nullable
              as List<QueryDocumentSnapshot<T>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagingStateImplCopyWith<T, $Res>
    implements $PagingStateCopyWith<T, $Res> {
  factory _$$PagingStateImplCopyWith(_$PagingStateImpl<T> value,
          $Res Function(_$PagingStateImpl<T>) then) =
      __$$PagingStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool hasMore, List<QueryDocumentSnapshot<T>> snapshots});
}

/// @nodoc
class __$$PagingStateImplCopyWithImpl<T, $Res>
    extends _$PagingStateCopyWithImpl<T, $Res, _$PagingStateImpl<T>>
    implements _$$PagingStateImplCopyWith<T, $Res> {
  __$$PagingStateImplCopyWithImpl(
      _$PagingStateImpl<T> _value, $Res Function(_$PagingStateImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasMore = null,
    Object? snapshots = null,
  }) {
    return _then(_$PagingStateImpl<T>(
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      snapshots: null == snapshots
          ? _value._snapshots
          : snapshots // ignore: cast_nullable_to_non_nullable
              as List<QueryDocumentSnapshot<T>>,
    ));
  }
}

/// @nodoc

class _$PagingStateImpl<T> extends _PagingState<T> {
  _$PagingStateImpl(
      {required this.hasMore,
      required final List<QueryDocumentSnapshot<T>> snapshots})
      : _snapshots = snapshots,
        super._();

  @override
  final bool hasMore;
  final List<QueryDocumentSnapshot<T>> _snapshots;
  @override
  List<QueryDocumentSnapshot<T>> get snapshots {
    if (_snapshots is EqualUnmodifiableListView) return _snapshots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_snapshots);
  }

  @override
  String toString() {
    return 'PagingState<$T>(hasMore: $hasMore, snapshots: $snapshots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingStateImpl<T> &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            const DeepCollectionEquality()
                .equals(other._snapshots, _snapshots));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, hasMore, const DeepCollectionEquality().hash(_snapshots));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingStateImplCopyWith<T, _$PagingStateImpl<T>> get copyWith =>
      __$$PagingStateImplCopyWithImpl<T, _$PagingStateImpl<T>>(
          this, _$identity);
}

abstract class _PagingState<T> extends PagingState<T> {
  factory _PagingState(
          {required final bool hasMore,
          required final List<QueryDocumentSnapshot<T>> snapshots}) =
      _$PagingStateImpl<T>;
  _PagingState._() : super._();

  @override
  bool get hasMore;
  @override
  List<QueryDocumentSnapshot<T>> get snapshots;
  @override
  @JsonKey(ignore: true)
  _$$PagingStateImplCopyWith<T, _$PagingStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
