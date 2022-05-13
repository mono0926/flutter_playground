import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mono_kit/utils/logger.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      shortcuts: {
        ...WidgetsApp.defaultShortcuts,
        LogicalKeySet(LogicalKeyboardKey.keyA): const AIntent(),
      },
      actions: {
        ...WidgetsApp.defaultActions,
        AIntent: AAction(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Dog'),
      ),
    );
  }
}

class AIntent extends Intent {
  const AIntent();
}

class AAction extends Action<Intent> {
  @override
  void invoke(Intent intent) {
    logger.info(intent);
  }
}
