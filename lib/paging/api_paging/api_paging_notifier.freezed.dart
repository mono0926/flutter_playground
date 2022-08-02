// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'api_paging_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PagingState<T> {
  bool get hasMore => throw _privateConstructorUsedError;
  List<T> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PagingStateCopyWith<T, PagingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingStateCopyWith<T, $Res> {
  factory $PagingStateCopyWith(
          PagingState<T> value, $Res Function(PagingState<T>) then) =
      _$PagingStateCopyWithImpl<T, $Res>;
  $Res call({bool hasMore, List<T> items});
}

/// @nodoc
class _$PagingStateCopyWithImpl<T, $Res>
    implements $PagingStateCopyWith<T, $Res> {
  _$PagingStateCopyWithImpl(this._value, this._then);

  final PagingState<T> _value;
  // ignore: unused_field
  final $Res Function(PagingState<T>) _then;

  @override
  $Res call({
    Object? hasMore = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      hasMore: hasMore == freezed
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
abstract class _$$_PagingStateCopyWith<T, $Res>
    implements $PagingStateCopyWith<T, $Res> {
  factory _$$_PagingStateCopyWith(
          _$_PagingState<T> value, $Res Function(_$_PagingState<T>) then) =
      __$$_PagingStateCopyWithImpl<T, $Res>;
  @override
  $Res call({bool hasMore, List<T> items});
}

/// @nodoc
class __$$_PagingStateCopyWithImpl<T, $Res>
    extends _$PagingStateCopyWithImpl<T, $Res>
    implements _$$_PagingStateCopyWith<T, $Res> {
  __$$_PagingStateCopyWithImpl(
      _$_PagingState<T> _value, $Res Function(_$_PagingState<T>) _then)
      : super(_value, (v) => _then(v as _$_PagingState<T>));

  @override
  _$_PagingState<T> get _value => super._value as _$_PagingState<T>;

  @override
  $Res call({
    Object? hasMore = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_PagingState<T>(
      hasMore: hasMore == freezed
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_PagingState<T> extends _PagingState<T> {
  _$_PagingState({this.hasMore = true, required final List<T> items})
      : _items = items,
        super._();

  @override
  @JsonKey()
  final bool hasMore;
  final List<T> _items;
  @override
  List<T> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PagingState<$T>(hasMore: $hasMore, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PagingState<T> &&
            const DeepCollectionEquality().equals(other.hasMore, hasMore) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(hasMore),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  _$$_PagingStateCopyWith<T, _$_PagingState<T>> get copyWith =>
      __$$_PagingStateCopyWithImpl<T, _$_PagingState<T>>(this, _$identity);
}

abstract class _PagingState<T> extends PagingState<T> {
  factory _PagingState({final bool hasMore, required final List<T> items}) =
      _$_PagingState<T>;
  _PagingState._() : super._();

  @override
  bool get hasMore;
  @override
  List<T> get items;
  @override
  @JsonKey(ignore: true)
  _$$_PagingStateCopyWith<T, _$_PagingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
