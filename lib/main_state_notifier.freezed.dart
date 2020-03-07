// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'main_state_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

mixin _$Counter {
  int get count;

  Counter copyWith({int count});
}

class _$CounterTearOff {
  const _$CounterTearOff();

  _Counter call({@required int count}) {
    return _Counter(
      count: count,
    );
  }
}

const $Counter = _$CounterTearOff();

class _$_Counter with DiagnosticableTreeMixin implements _Counter {
  const _$_Counter({@required this.count}) : assert(count != null);

  @override
  final int count;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Counter(count: $count)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Counter'))
      ..add(DiagnosticsProperty('count', count));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Counter &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(count);

  @override
  _$_Counter copyWith({
    Object count = freezed,
  }) {
    return _$_Counter(
      count: count == freezed ? this.count : count as int,
    );
  }
}

abstract class _Counter implements Counter {
  const factory _Counter({@required int count}) = _$_Counter;

  @override
  int get count;

  @override
  _Counter copyWith({int count});
}
