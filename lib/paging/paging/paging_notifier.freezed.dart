// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PagingState<T> {

 bool get hasMore; List<QueryDocumentSnapshot<T>> get snapshots;
/// Create a copy of PagingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagingStateCopyWith<T, PagingState<T>> get copyWith => _$PagingStateCopyWithImpl<T, PagingState<T>>(this as PagingState<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagingState<T>&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other.snapshots, snapshots));
}


@override
int get hashCode => Object.hash(runtimeType,hasMore,const DeepCollectionEquality().hash(snapshots));

@override
String toString() {
  return 'PagingState<$T>(hasMore: $hasMore, snapshots: $snapshots)';
}


}

/// @nodoc
abstract mixin class $PagingStateCopyWith<T,$Res>  {
  factory $PagingStateCopyWith(PagingState<T> value, $Res Function(PagingState<T>) _then) = _$PagingStateCopyWithImpl;
@useResult
$Res call({
 bool hasMore, List<QueryDocumentSnapshot<T>> snapshots
});




}
/// @nodoc
class _$PagingStateCopyWithImpl<T,$Res>
    implements $PagingStateCopyWith<T, $Res> {
  _$PagingStateCopyWithImpl(this._self, this._then);

  final PagingState<T> _self;
  final $Res Function(PagingState<T>) _then;

/// Create a copy of PagingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasMore = null,Object? snapshots = null,}) {
  return _then(_self.copyWith(
hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,snapshots: null == snapshots ? _self.snapshots : snapshots // ignore: cast_nullable_to_non_nullable
as List<QueryDocumentSnapshot<T>>,
  ));
}

}


/// Adds pattern-matching-related methods to [PagingState].
extension PagingStatePatterns<T> on PagingState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagingState<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagingState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagingState<T> value)  $default,){
final _that = this;
switch (_that) {
case _PagingState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagingState<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PagingState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasMore,  List<QueryDocumentSnapshot<T>> snapshots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagingState() when $default != null:
return $default(_that.hasMore,_that.snapshots);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasMore,  List<QueryDocumentSnapshot<T>> snapshots)  $default,) {final _that = this;
switch (_that) {
case _PagingState():
return $default(_that.hasMore,_that.snapshots);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasMore,  List<QueryDocumentSnapshot<T>> snapshots)?  $default,) {final _that = this;
switch (_that) {
case _PagingState() when $default != null:
return $default(_that.hasMore,_that.snapshots);case _:
  return null;

}
}

}

/// @nodoc


class _PagingState<T> extends PagingState<T> {
   _PagingState({required this.hasMore, required final  List<QueryDocumentSnapshot<T>> snapshots}): _snapshots = snapshots,super._();
  

@override final  bool hasMore;
 final  List<QueryDocumentSnapshot<T>> _snapshots;
@override List<QueryDocumentSnapshot<T>> get snapshots {
  if (_snapshots is EqualUnmodifiableListView) return _snapshots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_snapshots);
}


/// Create a copy of PagingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagingStateCopyWith<T, _PagingState<T>> get copyWith => __$PagingStateCopyWithImpl<T, _PagingState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagingState<T>&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._snapshots, _snapshots));
}


@override
int get hashCode => Object.hash(runtimeType,hasMore,const DeepCollectionEquality().hash(_snapshots));

@override
String toString() {
  return 'PagingState<$T>(hasMore: $hasMore, snapshots: $snapshots)';
}


}

/// @nodoc
abstract mixin class _$PagingStateCopyWith<T,$Res> implements $PagingStateCopyWith<T, $Res> {
  factory _$PagingStateCopyWith(_PagingState<T> value, $Res Function(_PagingState<T>) _then) = __$PagingStateCopyWithImpl;
@override @useResult
$Res call({
 bool hasMore, List<QueryDocumentSnapshot<T>> snapshots
});




}
/// @nodoc
class __$PagingStateCopyWithImpl<T,$Res>
    implements _$PagingStateCopyWith<T, $Res> {
  __$PagingStateCopyWithImpl(this._self, this._then);

  final _PagingState<T> _self;
  final $Res Function(_PagingState<T>) _then;

/// Create a copy of PagingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasMore = null,Object? snapshots = null,}) {
  return _then(_PagingState<T>(
hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,snapshots: null == snapshots ? _self._snapshots : snapshots // ignore: cast_nullable_to_non_nullable
as List<QueryDocumentSnapshot<T>>,
  ));
}


}

// dart format on
