import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Show Confirmation Dialog'),
          onPressed: () async {
            // animationsパッケージのshowModalがベター
            final animal = await showDialog<String?>(
              context: context,
              builder: (context) {
                return const _ConfirmationDialog();
              },
            );
            print(animal);
          },
        ),
      ),
    );
  }
}

class _ConfirmationDialog extends StatefulWidget {
  const _ConfirmationDialog();

  @override
  State<_ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<_ConfirmationDialog> {
  final animals = ['Dog', 'Cat', 'Rabbit', 'Horse', 'Pig'];
  late String? _selected = animals.first;
  var _shrinkWrap = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Favorite Animal',
                style: theme.textTheme.titleLarge,
              ),
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: Text(
                'ListView(shrinkWrap: $_shrinkWrap)',
              ),
              value: _shrinkWrap,
              onChanged: (value) => setState(() => _shrinkWrap = value),
            ),
            const Divider(height: 0),
            // Expandedだと縮まなくて`shrinkWrap: true`の時に適切に縮まない🙅‍♀️
            // (`fit: FlexFit.loose`であることが重要)
            Flexible(
              child: ListView(
                // Defaults to false
                shrinkWrap: _shrinkWrap,
                children: animals
                    .map(
                      (animal) => RadioListTile<String>(
                        title: Text(animal),
                        value: animal,
                        groupValue: _selected,
                        onChanged: (value) {
                          setState(() {
                            _selected = value;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(height: 0),
            ButtonBar(
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              children: [
                TextButton(
                  child: Text(
                    MaterialLocalizations.of(context).cancelButtonLabel,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  onPressed: _selected == null
                      ? null
                      : () => Navigator.of(context).pop(_selected),
                  child: Text(
                    MaterialLocalizations.of(context).okButtonLabel,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
