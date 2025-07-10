// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_state_notifier2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Counter1 implements DiagnosticableTreeMixin {

 int get count;
/// Create a copy of Counter1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Counter1CopyWith<Counter1> get copyWith => _$Counter1CopyWithImpl<Counter1>(this as Counter1, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Counter1'))
    ..add(DiagnosticsProperty('count', count));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Counter1&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Counter1(count: $count)';
}


}

/// @nodoc
abstract mixin class $Counter1CopyWith<$Res>  {
  factory $Counter1CopyWith(Counter1 value, $Res Function(Counter1) _then) = _$Counter1CopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$Counter1CopyWithImpl<$Res>
    implements $Counter1CopyWith<$Res> {
  _$Counter1CopyWithImpl(this._self, this._then);

  final Counter1 _self;
  final $Res Function(Counter1) _then;

/// Create a copy of Counter1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Counter1].
extension Counter1Patterns on Counter1 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Counter1 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Counter1() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Counter1 value)  $default,){
final _that = this;
switch (_that) {
case _Counter1():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Counter1 value)?  $default,){
final _that = this;
switch (_that) {
case _Counter1() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Counter1() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count)  $default,) {final _that = this;
switch (_that) {
case _Counter1():
return $default(_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count)?  $default,) {final _that = this;
switch (_that) {
case _Counter1() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _Counter1 with DiagnosticableTreeMixin implements Counter1 {
  const _Counter1({required this.count});
  

@override final  int count;

/// Create a copy of Counter1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Counter1CopyWith<_Counter1> get copyWith => __$Counter1CopyWithImpl<_Counter1>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Counter1'))
    ..add(DiagnosticsProperty('count', count));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Counter1&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Counter1(count: $count)';
}


}

/// @nodoc
abstract mixin class _$Counter1CopyWith<$Res> implements $Counter1CopyWith<$Res> {
  factory _$Counter1CopyWith(_Counter1 value, $Res Function(_Counter1) _then) = __$Counter1CopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$Counter1CopyWithImpl<$Res>
    implements _$Counter1CopyWith<$Res> {
  __$Counter1CopyWithImpl(this._self, this._then);

  final _Counter1 _self;
  final $Res Function(_Counter1) _then;

/// Create a copy of Counter1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_Counter1(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Counter2 implements DiagnosticableTreeMixin {

 int get count;
/// Create a copy of Counter2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Counter2CopyWith<Counter2> get copyWith => _$Counter2CopyWithImpl<Counter2>(this as Counter2, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Counter2'))
    ..add(DiagnosticsProperty('count', count));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Counter2&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Counter2(count: $count)';
}


}

/// @nodoc
abstract mixin class $Counter2CopyWith<$Res>  {
  factory $Counter2CopyWith(Counter2 value, $Res Function(Counter2) _then) = _$Counter2CopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$Counter2CopyWithImpl<$Res>
    implements $Counter2CopyWith<$Res> {
  _$Counter2CopyWithImpl(this._self, this._then);

  final Counter2 _self;
  final $Res Function(Counter2) _then;

/// Create a copy of Counter2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Counter2].
extension Counter2Patterns on Counter2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Counter2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Counter2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Counter2 value)  $default,){
final _that = this;
switch (_that) {
case _Counter2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Counter2 value)?  $default,){
final _that = this;
switch (_that) {
case _Counter2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Counter2() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count)  $default,) {final _that = this;
switch (_that) {
case _Counter2():
return $default(_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count)?  $default,) {final _that = this;
switch (_that) {
case _Counter2() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _Counter2 with DiagnosticableTreeMixin implements Counter2 {
  const _Counter2({required this.count});
  

@override final  int count;

/// Create a copy of Counter2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Counter2CopyWith<_Counter2> get copyWith => __$Counter2CopyWithImpl<_Counter2>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Counter2'))
    ..add(DiagnosticsProperty('count', count));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Counter2&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Counter2(count: $count)';
}


}

/// @nodoc
abstract mixin class _$Counter2CopyWith<$Res> implements $Counter2CopyWith<$Res> {
  factory _$Counter2CopyWith(_Counter2 value, $Res Function(_Counter2) _then) = __$Counter2CopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$Counter2CopyWithImpl<$Res>
    implements _$Counter2CopyWith<$Res> {
  __$Counter2CopyWithImpl(this._self, this._then);

  final _Counter2 _self;
  final $Res Function(_Counter2) _then;

/// Create a copy of Counter2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_Counter2(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
