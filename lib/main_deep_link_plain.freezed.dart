// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main_deep_link_plain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_User(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User extends _User {
  const _$_User({required this.name}) : super._();

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'User(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(this);
  }
}

abstract class _User extends User {
  const factory _User({required final String name}) = _$_User;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Document<E> {
  String get id => throw _privateConstructorUsedError;
  E get entity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DocumentCopyWith<E, Document<E>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<E, $Res> {
  factory $DocumentCopyWith(
          Document<E> value, $Res Function(Document<E>) then) =
      _$DocumentCopyWithImpl<E, $Res>;
  $Res call({String id, E entity});
}

/// @nodoc
class _$DocumentCopyWithImpl<E, $Res> implements $DocumentCopyWith<E, $Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  final Document<E> _value;
  // ignore: unused_field
  final $Res Function(Document<E>) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? entity = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entity: entity == freezed
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as E,
    ));
  }
}

/// @nodoc
abstract class _$DocumentCopyWith<E, $Res>
    implements $DocumentCopyWith<E, $Res> {
  factory _$DocumentCopyWith(
          _Document<E> value, $Res Function(_Document<E>) then) =
      __$DocumentCopyWithImpl<E, $Res>;
  @override
  $Res call({String id, E entity});
}

/// @nodoc
class __$DocumentCopyWithImpl<E, $Res> extends _$DocumentCopyWithImpl<E, $Res>
    implements _$DocumentCopyWith<E, $Res> {
  __$DocumentCopyWithImpl(
      _Document<E> _value, $Res Function(_Document<E>) _then)
      : super(_value, (v) => _then(v as _Document<E>));

  @override
  _Document<E> get _value => super._value as _Document<E>;

  @override
  $Res call({
    Object? id = freezed,
    Object? entity = freezed,
  }) {
    return _then(_Document<E>(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      entity == freezed
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as E,
    ));
  }
}

/// @nodoc

class _$_Document<E> extends _Document<E> {
  const _$_Document(this.id, this.entity) : super._();

  @override
  final String id;
  @override
  final E entity;

  @override
  String toString() {
    return 'Document<$E>(id: $id, entity: $entity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Document<E> &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.entity, entity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(entity));

  @JsonKey(ignore: true)
  @override
  _$DocumentCopyWith<E, _Document<E>> get copyWith =>
      __$DocumentCopyWithImpl<E, _Document<E>>(this, _$identity);
}

abstract class _Document<E> extends Document<E> {
  const factory _Document(final String id, final E entity) = _$_Document<E>;
  const _Document._() : super._();

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  E get entity => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DocumentCopyWith<E, _Document<E>> get copyWith =>
      throw _privateConstructorUsedError;
}
