import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//We add the [SingleTickerProviderStateMixin] because it allows us to create an
//[AnimationController] within the class
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin<MyHomePage> {
  ///The animation controller that starts the slide effect
  // ignore: lines_longer_than_80_chars
  late final AnimationController _slideAnimationController =
      AnimationController(
    vsync: this,
    //whatever duration you want
    duration: const Duration(milliseconds: 400),
  );

  ///The animation that creates the slide up effect by controlling the height
  ///factor of the [Align] widget
  late final Animation<double> _heightFactorAnimation = CurvedAnimation(
    parent: _slideAnimationController.drive(
      //a Tween from 1.0 to 0.0 is what makes the slide effect by shrinking
      // the container using the [Align.heightFactor] parameter
      Tween<double>(
        begin: 1,
        end: 0,
      ),
    ),
    curve: Curves.ease,
  );

  ///Governs whether to show the banner or not. We use a [ValueNotifier]
  ///because the visibility changes asynchronously when the animation finishes,
  ///which we want to trigger the rebuild of [ValueListenableBuilder] That
  ///listens to this value
  final _isVisibleValueNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          //This is where the magic begins
          ValueListenableBuilder<bool>(
            valueListenable: _isVisibleValueNotifier,
            builder: (context, isVisible, child) {
              return Visibility(
                visible: isVisible,
                child: child!,
              );
            },
            child: AnimatedBuilder(
              animation: _slideAnimationController,
              builder: (context, child) {
                return ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: _heightFactorAnimation.value,
                    child: child,
                  ),
                );
              },
              //This is where the magic ends. Just so we're clear

              //we wrap our content in the child param as it is not affected by
              // the animation itself
              child: MaterialBanner(
                content: const Text('This is a banner. Dismiss me'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      //pressing the button will start the animation
                      await _slideAnimationController.forward();
                      _isVisibleValueNotifier.value = false;
                    },
                    child: const Text('DISMISS'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            color: Colors.blue,
            child: const Text('A Container'),
          ),
        ],
      ),
    );
  }
}
