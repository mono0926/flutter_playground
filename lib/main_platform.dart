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
        // TODO(mono): それぞれの要素タップでドキュメントへ飛ぶようにしたい
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
          ListTile(
            title: Text(defaultTargetPlatform.name),
            subtitle: const Text('defaultTargetPlatform'),
          ),
          ListTile(
            title: Text(theme.platform.name),
            subtitle: const Text('Theme.of(context).platform'),
          ),
          const ListTile(
            title: Text('$kIsWeb'),
            subtitle: Text('kIsWeb'),
          ),
          ListTile(
            title: Text('${!kIsWeb && Platform.isAndroid}'),
            subtitle: const Text('Platform.isAndroid'),
          ),
          ListTile(
            title: Text('${!kIsWeb && Platform.isIOS}'),
            subtitle: const Text('Platform.isIOS'),
          ),
          ListTile(
            title: Text('${!kIsWeb && Platform.isMacOS}'),
            subtitle: const Text('Platform.isMacOS'),
          ),
          ListTile(
            title: Text('${!kIsWeb && Platform.isWindows}'),
            subtitle: const Text('Platform.isWindows'),
          ),
          ListTile(
            title: Text('${!kIsWeb && Platform.isLinux}'),
            subtitle: const Text('Platform.isLinux'),
          ),
          ListTile(
            title: Text('${!kIsWeb && Platform.isFuchsia}'),
            subtitle: const Text('Platform.isFuchsia'),
          ),
          ListTile(
            title: Text('${theme.visualDensity}'),
            subtitle: const Text('Theme.of(context).visualDensity'),
          ),
          ListTile(
            title: Text(theme.materialTapTargetSize.name),
            subtitle: const Text('Theme.of(context).materialTapTargetSize'),
          ),
          // https://docs.flutter.dev/release/breaking-changes/default-desktop-scrollbars
          // https://github.com/flutter/flutter/blob/676cefaaff197f27424942307668886253e1ec35/packages/flutter/lib/src/material/app.dart#L768-L786
          ListTile(
            title: Text('${ScrollConfiguration.of(context)}'),
            subtitle: const Text('Theme.of(context).materialTapTargetSize'),
          ),
          const Divider(),
          AboutListTile(
            icon: const Icon(Icons.info),
            aboutBoxChildren: [
              TextButton.icon(
                label: const Text('Source Code'),
                onPressed: () => launchUrl(
                  Uri.parse(
                    'https://github.com/mono0926/flutter_playground/blob/main/lib/main_platform.dart',
                  ),
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
