import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//We add the [SingleTickerProviderStateMixin] because it allows us to create an
//[AnimationController] within the class
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin<MyHomePage> {
  ///The animation controller that starts the slide effect
  AnimationController _slideAnimationController;

  ///The animation that creates the slide up effect by controlling the height
  ///factor of the [Align] widget
  Animation<double> _heightFactorAnimation;

  ///Governs whether to show the banner or not. We use a [ValueNotifier]
  ///because the visibility changes asynchronously when the animation finishes,
  ///which we want to trigger the rebuild of [ValueListenableBuilder] That
  ///listens to this value
  ValueNotifier<bool> _isVisibleValueNotifier = ValueNotifier(true);

  @override
  void initState() {
    _slideAnimationController = AnimationController(
      vsync: this,
      //whatever duration you want
      duration: Duration(milliseconds: 400),
    );
    _heightFactorAnimation = CurvedAnimation(
        parent: _slideAnimationController.drive(
          //a Tween from 1.0 to 0.0 is what makes the slide effect by shrinking
          // the container using the [Align.heightFactor] parameter
          Tween<double>(
            begin: 1.0,
            end: 0.0,
          ),
        ),
        curve: Curves.ease);
    super.initState();
  }

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
                child: child,
              );
            },
            child: AnimatedBuilder(
              animation: _slideAnimationController,
              builder: (BuildContext context, Widget child) {
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
                content: Text('This is a banner. Dismiss me'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      //pressing the button will start the animation
                      await _slideAnimationController.forward();
                      _isVisibleValueNotifier.value = false;
                    },
                    child: Text('DISMISS'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            color: Colors.blue,
            child: Text('A Container'),
          ),
        ],
      ),
    );
  }
}
