// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_deep_link.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
    ];

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'users',
          factory: $UsersRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':userId',
              factory: $UserRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}

extension $UsersRouteExtension on UsersRoute {
  static UsersRoute _fromState(GoRouterState state) => const UsersRoute();

  String get location => GoRouteData.$location(
        '/users',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}

extension $UserRouteExtension on UserRoute {
  static UserRoute _fromState(GoRouterState state) => UserRoute(
        state.params['userId']!,
      );

  String get location => GoRouteData.$location(
        '/users/${Uri.encodeComponent(userId)}',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map json) => _$_User(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'name': instance.name,
    };
