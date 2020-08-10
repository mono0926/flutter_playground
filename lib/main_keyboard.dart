import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => KeyboardShortcutController(),
        builder: (context, child) => Focus(
          onKey: (node, event) {
            if (event is RawKeyDownEvent &&
                FocusManager.instance.primaryFocus.context.widget
                    is! EditableText) {
              context.read<KeyboardShortcutController>().keyboardKey =
                  event.logicalKey;
            }
            return false;
          },
          child: child,
        ),
        child: const App(),
      ),
    );

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              KeyboardShortcut(
                LogicalKeyboardKey.keyA,
                button: RaisedButton(
                  child: const Text(
                    'A (react to A key unless TextField is focused',
                  ),
                  onPressed: () {
                    print('A');
                  },
                ),
              ),
              RaisedButton(
                child: const Text('B'),
                onPressed: () {
                  print('B');
                },
              ),
              TextField(),
            ],
          ),
        ),
      ),
    );
  }
}

class KeyboardShortcutController extends ChangeNotifier {
  LogicalKeyboardKey _keyboardKey;

  set keyboardKey(LogicalKeyboardKey keyboardKey) {
    _keyboardKey = keyboardKey;
    notifyListeners();
  }

  LogicalKeyboardKey get keyboardKey => _keyboardKey;
}

class KeyboardShortcut extends StatefulWidget {
  const KeyboardShortcut(
    this.keyboardKey, {
    Key key,
    @required this.button,
  }) : super(key: key);
  @override
  _KeyboardShortcutState createState() => _KeyboardShortcutState();

  final LogicalKeyboardKey keyboardKey;
  final MaterialButton button;
}

class _KeyboardShortcutState extends State<KeyboardShortcut> {
  @override
  void initState() {
    super.initState();

    final notifier = Provider.of<KeyboardShortcutController>(
      context,
      listen: false,
    );
    notifier.addListener(() {
      if (notifier.keyboardKey == widget.keyboardKey &&
          widget.button.onPressed != null) {
        print('KeyboardShortcut: ${widget.keyboardKey}');
        widget.button.onPressed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.button;
  }
}
