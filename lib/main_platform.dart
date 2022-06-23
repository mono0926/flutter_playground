import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const ProviderScope(child: App()));
}

const title = 'Platform example';

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
        centerTitle: false,
      ),
      body: ListView(
        children: [
          _PlatformDropdownButtonTile(
            label: 'Theme(platform:) =',
            platform: ref.watch(platformProvider),
            onChanged: (platform) =>
                ref.read(platformProvider.notifier).update((_) => platform),
          ),
          _PlatformDropdownButtonTile(
            label: 'debugDefaultTargetPlatformOverride =',
            platform: ref.watch(debugDefaultTargetPlatformOverrideProvider),
            onChanged: (platform) => ref
                .read(
                  debugDefaultTargetPlatformOverrideProvider.notifier,
                )
                .update((_) => platform),
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
            label: 'ScrollConfiguration',
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

final platformProvider = StateProvider<TargetPlatform?>((ref) => null);

final debugDefaultTargetPlatformOverrideProvider =
    StateProvider<TargetPlatform?>((ref) => null);

class _PlatformDropdownButtonTile extends StatelessWidget {
  const _PlatformDropdownButtonTile({
    required this.label,
    required this.platform,
    required this.onChanged,
  });

  final String label;
  final TargetPlatform? platform;
  final ValueChanged<TargetPlatform?> onChanged;

  @override
  Widget build(BuildContext context) {
    return TilePadding(
      child: Row(
        children: [
          Expanded(child: Text(label)),
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

void _launch(String url) => launchUrl(Uri.parse(url));
