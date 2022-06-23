import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:mono_kit/mono_kit.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const ProviderScope(child: App()));
}

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform example'),
        centerTitle: false,
      ),
      body: ListView(
        // TODO(mono): それぞれの要素タップでドキュメントへ飛ぶようにしたい
        children: [
          TilePadding(
            child: Table(
              columnWidths: const {
                1: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const Text('Theme(platform:) ='),
                    _PlatformDropdownButton(
                      platform: ref.watch(platformProvider),
                      onChanged: (platform) => ref
                          .read(platformProvider.notifier)
                          .update((_) => platform),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('debugDefaultTargetPlatformOverride ='),
                    _PlatformDropdownButton(
                      platform:
                          ref.watch(debugDefaultTargetPlatformOverrideProvider),
                      onChanged: (platform) => ref
                          .read(
                            debugDefaultTargetPlatformOverrideProvider.notifier,
                          )
                          .update((_) => platform),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(defaultTargetPlatform.name),
            subtitle: const Text('defaultTargetPlatform'),
          ),
          ListTile(
            title: Text(Theme.of(context).platform.name),
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
        ],
      ),
    );
  }
}

final platformProvider = StateProvider<TargetPlatform?>((ref) => null);

final debugDefaultTargetPlatformOverrideProvider =
    StateProvider<TargetPlatform?>((ref) => null);

class _PlatformDropdownButton extends StatelessWidget {
  const _PlatformDropdownButton({
    required this.platform,
    required this.onChanged,
  });

  final TargetPlatform? platform;
  final ValueChanged<TargetPlatform?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TargetPlatform?>(
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
    );
  }
}
