import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: const ColorScheme.light()),
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark()),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: ListView(
        children: [
          const PeriodicTimerTile(),
          const PeriodicTimerTile(
            mutedFuture: true,
          ),
          const AnimationTimerTile(),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => const SecondPage(),
              ),
            ),
            child: const Text('NEXT PAGE'),
          )
        ],
      ),
    );
  }
}

class PeriodicTimerTile extends StatefulWidget {
  const PeriodicTimerTile({
    super.key,
    this.mutedFuture = false,
  });

  final bool mutedFuture;

  @override
  _PeriodicTimerTileState createState() => _PeriodicTimerTileState();
}

class _PeriodicTimerTileState extends State<PeriodicTimerTile> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      // Can be modified to large number.
      const Duration(milliseconds: 16),
      (timer) {
        if (!widget.mutedFuture || TickerMode.of(context)) {
          print(
            'PeriodicTimerTile (mute: ${widget.mutedFuture}) '
            'value will be changed',
          );
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        DateTime.now().toIso8601String(),
      ),
      subtitle: Text('Timer.periodic (mute: ${widget.mutedFuture})'),
    );
  }
}

class AnimationTimerTile extends StatefulWidget {
  const AnimationTimerTile({super.key});

  @override
  _AnimationTimerTileState createState() => _AnimationTimerTileState();
}

class _AnimationTimerTileState extends State<AnimationTimerTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )
    ..repeat()
    ..addListener(() {
      // Not called when navigated to NextPage by virtue of
      // AnimationController's muted feature.
      print('AnimationTimerTile value will be changed');
      setState(() {});
    });

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        DateTime.now().toIso8601String(),
      ),
      subtitle: const Text('AnimationController'),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  static const routeName = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          routeName,
        ),
      ),
    );
  }
}
