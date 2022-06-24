import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const ProviderScope(child: App()));
}

const title = 'Platform example';

void _launch(String url) => launchUrl(Uri.parse(url));

final platformProvider = StateProvider<TargetPlatform?>(
  (ref) => null,
);

final debugDefaultTargetPlatformOverrideProvider =
    StateProvider<TargetPlatform?>(
  (ref) => null,
);

final haveScrollBarProvider = StateProvider((ref) => false);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値が変わったらリビルド走らせたい(Theme再生成したい)ので、watchしつつセット
    debugDefaultTargetPlatformOverride =
        ref.watch(debugDefaultTargetPlatformOverrideProvider);
    // デフォルトnull
    final selectedPlatform = ref.watch(platformProvider);
    print('selectedPlatform: $selectedPlatform');
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        platform: selectedPlatform,
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: ref.watch(haveScrollBarProvider)
          ? const _AlwaysHaveScrollBarBehavior()
          : null,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView(
        children: [
          _PlatformDropdownButtonTile(
            label: 'Theme(platform:) =',
            platform: ref.watch(platformProvider),
            onChanged: (platform) =>
                ref.read(platformProvider.notifier).update((_) => platform),
            url:
                'https://api.flutter.dev/flutter/material/ThemeData/platform.html',
          ),
          _PlatformDropdownButtonTile(
            label: 'debugDefaultTargetPlatformOverride =',
            platform: ref.watch(debugDefaultTargetPlatformOverrideProvider),
            onChanged: (platform) => ref
                .read(
                  debugDefaultTargetPlatformOverrideProvider.notifier,
                )
                .update((_) => platform),
            url:
                'https://api.flutter.dev/flutter/foundation/debugDefaultTargetPlatformOverride.html',
          ),
          SwitchListTile.adaptive(
            title: const Text('Always Have ScrollBar'),
            subtitle: const Text(
              '通常はデスクトップ環境のみデフォルトでスクロールバーが表示されますが、オンにするとモバイル環境でも同様に表示されます。',
            ),
            value: ref.watch(haveScrollBarProvider),
            onChanged: (on) =>
                ref.read(haveScrollBarProvider.notifier).update((_) => on),
          ),
          const Divider(),
          _LinkTile(
            value: defaultTargetPlatform.name,
            label: 'defaultTargetPlatform',
            url:
                'https://api.flutter.dev/flutter/foundation/defaultTargetPlatform.html',
          ),
          _LinkTile(
            value: theme.platform.name,
            label: 'Theme.of(context).platform',
            url:
                'https://api.flutter.dev/flutter/material/ThemeData/platform.html',
          ),
          const _LinkTile(
            value: '$kIsWeb',
            label: 'kIsWeb',
            url:
                'https://api.flutter.dev/flutter/foundation/kIsWeb-constant.html',
          ),
          _LinkTile(
            value: '${!kIsWeb && Platform.isAndroid}',
            label: 'Platform.isAndroid',
            url:
                'https://api.flutter.dev/flutter/dart-io/Platform/isAndroid.html',
          ),
          _LinkTile(
            value: '${!kIsWeb && Platform.isIOS}',
            label: 'Platform.isIOS',
            url: 'https://api.flutter.dev/flutter/dart-io/Platform/isIOS.html',
          ),
          _LinkTile(
            value: '${!kIsWeb && Platform.isMacOS}',
            label: 'Platform.isMacOS',
            url:
                'https://api.flutter.dev/flutter/dart-io/Platform/isMacOS.html',
          ),
          _LinkTile(
            value: '${!kIsWeb && Platform.isWindows}',
            label: 'Platform.isWindows',
            url:
                'https://api.flutter.dev/flutter/dart-io/Platform/isWindows.html',
          ),
          _LinkTile(
            value: '${!kIsWeb && Platform.isLinux}',
            label: 'Platform.isLinux',
            url:
                'https://api.flutter.dev/flutter/dart-io/Platform/isLinux.html',
          ),
          _LinkTile(
            value: '${!kIsWeb && Platform.isFuchsia}',
            label: 'Platform.isFuchsia',
            url:
                'https://api.flutter.dev/flutter/dart-io/Platform/isFuchsia.html',
          ),
          _LinkTile(
            value: '${theme.visualDensity}',
            label: 'Theme.of(context).visualDensity',
            url:
                'https://api.flutter.dev/flutter/material/VisualDensity-class.html',
          ),
          _LinkTile(
            value: theme.materialTapTargetSize.name,
            label: 'Theme.of(context).materialTapTargetSize',
            url:
                'https://api.flutter.dev/flutter/material/MaterialTapTargetSize.html',
          ),
          // https://github.com/flutter/flutter/blob/676cefaaff197f27424942307668886253e1ec35/packages/flutter/lib/src/material/app.dart#L768-L786
          _LinkTile(
            value: '${ScrollConfiguration.of(context)}',
            label: 'crollConfiguration.of(context)',
            url:
                'https://docs.flutter.dev/release/breaking-changes/default-desktop-scrollbars',
          ),
          const Divider(),
          AboutListTile(
            icon: const Icon(Icons.info),
            aboutBoxChildren: [
              TextButton.icon(
                label: const Text('Source Code'),
                onPressed: () => _launch(
                  'https://github.com/mono0926/flutter_playground/blob/main/lib/main_platform.dart',
                ),
                icon: const Icon(Icons.open_in_browser),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlatformDropdownButtonTile extends StatelessWidget {
  const _PlatformDropdownButtonTile({
    required this.label,
    required this.platform,
    required this.onChanged,
    required this.url,
  });

  final String label;
  final TargetPlatform? platform;
  final ValueChanged<TargetPlatform?> onChanged;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: () => _launch(url),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<TargetPlatform?>(
            value: platform,
            items: [
              null,
              ...TargetPlatform.values,
            ]
                .map(
                  (platform) => DropdownMenuItem(
                    value: platform,
                    child: Text(platform?.name ?? 'null'),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
          const Gap(16),
          const Icon(Icons.open_in_browser),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({
    required this.value,
    required this.label,
    required this.url,
  });

  final String value;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(value),
      subtitle: Text(label),
      onTap: () => _launch(url),
      trailing: const Icon(Icons.open_in_browser),
    );
  }
}

class _AlwaysHaveScrollBarBehavior extends MaterialScrollBehavior {
  const _AlwaysHaveScrollBarBehavior();
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
    }
  }
}
