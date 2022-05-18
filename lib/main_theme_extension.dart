// https://github.com/flutter/flutter/blob/master/examples/api/lib/material/theme/theme_extension.1.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mono_kit/extensions/extensions.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brandColor,
    required this.danger,
  });

  final Color brandColor;
  final Color danger;

  @override
  AppColors copyWith({
    Color? brandColor,
    Color? danger,
  }) {
    return AppColors(
      brandColor: brandColor ?? this.brandColor,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }

  @override
  String toString() => 'AppColors(brandColor: $brandColor, danger: $danger)';
}

void main() {
// Slow down time to see lerping.
  timeDilation = 5.0;
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Code Sample',
      theme: lightTheme().copyWith(
        extensions: {
          const AppColors(
            brandColor: Color(0xFF1E88E5),
            danger: Color(0xFFE53935),
          ),
        },
      ),
      darkTheme: darkTheme().copyWith(
        extensions: {
          const AppColors(
            brandColor: Color(0xFF90CAF9),
            danger: Color(0xFFEF9A9A),
          ),
        },
      ),
      themeMode: ref.watch(themeModeProvider),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(width: 100, height: 100, color: appColors.brandColor),
            const SizedBox(width: 10),
            Container(width: 100, height: 100, color: appColors.danger),
            const SizedBox(width: 50),
            IconButton(
              icon: Icon(
                theme.brightness == Brightness.light
                    ? Icons.nightlight
                    : Icons.wb_sunny,
              ),
              onPressed: () => ref.watch(themeModeProvider.notifier).toggle(),
            ),
          ],
        ),
      ),
    );
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);

  void toggle() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
