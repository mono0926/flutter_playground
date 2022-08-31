import 'package:flutter/material.dart';

class DialogButtons extends StatelessWidget {
  const DialogButtons({super.key});

  @override
  Widget build(BuildContext context) {
    void dismissDialog() {
      Navigator.of(context).pop();
    }

    void showDemoDialog(
      String message,
      ButtonStyle style1, [
      ButtonStyle? style2,
    ]) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: Text(message),
            actions: <Widget>[
              OutlinedButton(
                style: style1,
                onPressed: dismissDialog,
                child: const Text('Approve'),
              ),
              OutlinedButton(
                style: style2 ?? style1,
                onPressed: dismissDialog,
                child: const Text('Really Approve'),
              ),
            ],
          );
        },
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              showDemoDialog(
                'Stadium shaped action buttons, default outline.',
                OutlinedButton.styleFrom(shape: const StadiumBorder()),
              );
            },
            child: const Text('Show an AlertDialog'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDemoDialog(
                'One Stadium shaped action button, with a heavy, primary color '
                'outline.',
                OutlinedButton.styleFrom(shape: const StadiumBorder()),
                OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            },
            child: const Text('Show another AlertDialog'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDemoDialog(
                'Stadium shaped action buttons, with a heavy, primary color '
                'outline when the button is focused or hovered',
                OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                ).copyWith(
                  side: MaterialStateProperty.resolveWith<BorderSide?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.focused)) {
                        return BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        );
                      }
                      return null; // defer to the default
                    },
                  ),
                ),
              );
            },
            child: const Text('Show yet another AlertDialog'),
          ),
        ],
      ),
    );
  }
}

class IndividuallySizedButtons extends StatefulWidget {
  const IndividuallySizedButtons({super.key});

  @override
  State<IndividuallySizedButtons> createState() =>
      _IndividuallySizedButtonsState();
}

class _IndividuallySizedButtonsState extends State<IndividuallySizedButtons> {
  bool _textButtonFlag = false;
  bool _containedButtonFlag = false;
  bool _outlinedButtonFlag = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const spacer = SizedBox(height: 16);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          spacer,
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  _textButtonFlag ? textTheme.headline2 : textTheme.headline4,
            ),
            onPressed: () {
              setState(() {
                _textButtonFlag = !_textButtonFlag;
              });
            },
            child: const Text('TEXT'),
          ),
          spacer,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: _containedButtonFlag
                  ? textTheme.headline2
                  : textTheme.headline4,
            ),
            onPressed: () {
              setState(() {
                _containedButtonFlag = !_containedButtonFlag;
              });
            },
            child: const Text('CONTAINED'),
          ),
          spacer,
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              textStyle: _outlinedButtonFlag
                  ? textTheme.headline2
                  : textTheme.headline4,
            ),
            onPressed: () {
              setState(() {
                _outlinedButtonFlag = !_outlinedButtonFlag;
              });
            },
            child: const Text('OUTLINED'),
          ),
          spacer,
        ],
      ),
    );
  }
}

class ShapeButtons extends StatefulWidget {
  const ShapeButtons({super.key});

  @override
  State<ShapeButtons> createState() => _ShapeButtonsState();
}

class _ShapeButtonsState extends State<ShapeButtons> {
  int shapeIndex = 0;

  @override
  Widget build(BuildContext context) {
    const buttonShapes = [
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      StadiumBorder(),
    ];

    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(shape: buttonShapes[shapeIndex]),
      ),
      child: ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: buttonShapes[shapeIndex]),
        ),
        child: OutlinedButtonTheme(
          data: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(shape: buttonShapes[shapeIndex]),
          ),
          child: OverflowBox(
            maxWidth: double.infinity,
            child: DefaultButtons(
              onPressed: () {
                setState(() {
                  shapeIndex = (shapeIndex + 1) % buttonShapes.length;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TextStyleButtons extends StatefulWidget {
  const TextStyleButtons({super.key});

  @override
  State<TextStyleButtons> createState() => _TextStyleButtonsState();
}

class _TextStyleButtonsState extends State<TextStyleButtons> {
  bool _flag = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final style = _flag ? textTheme.headline1 : textTheme.headline4;
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: style),
      ),
      child: ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(textStyle: style),
        ),
        child: OutlinedButtonTheme(
          data: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(textStyle: style),
          ),
          child: OverflowBox(
            maxWidth: double.infinity,
            child: DefaultButtons(
              iconSize: _flag ? 64 : 24,
              onPressed: () {
                setState(() {
                  _flag = !_flag;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TextColorButtons extends StatefulWidget {
  const TextColorButtons({super.key});

  @override
  State<TextColorButtons> createState() => _TextColorButtonsState();
}

class _TextColorButtonsState extends State<TextColorButtons> {
  int index = 0;

  static const List<Color> foregroundColors = <Color>[
    Colors.red,
    Colors.purple,
    Colors.indigo,
    Colors.teal,
    Colors.lime,
    Colors.deepOrange,
    Colors.yellow,
  ];

  static const List<Color> backgroundColors = <Color>[
    Colors.lightBlue,
    Colors.yellow,
    Colors.grey,
    Colors.amber,
    Colors.orange,
    Colors.blue,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final foregroundColor = foregroundColors[index];
    final backgroundColor = backgroundColors[index];
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: foregroundColor),
      ),
      child: ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
        ),
        child: OutlinedButtonTheme(
          data: OutlinedButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: foregroundColor),
          ),
          child: DefaultButtons(
            onPressed: () {
              setState(() {
                index = (index + 1) % foregroundColors.length;
              });
            },
          ),
        ),
      ),
    );
  }
}

class DefaultButtons extends StatelessWidget {
  const DefaultButtons({super.key, this.onPressed, this.iconSize = 18});

  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    const Widget spacer = SizedBox(height: 4);
    final Widget icon = Icon(Icons.star, size: iconSize);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            onPressed: onPressed ?? () {},
            child: const Text('TEXT'),
          ),
          spacer,
          TextButton.icon(
            onPressed: onPressed ?? () {},
            icon: icon,
            label: const Text('TEXT'),
          ),
          spacer,
          TextButton.icon(
            onPressed: null,
            icon: icon,
            label: const Text('DISABLED'),
          ),
          spacer,
          ElevatedButton(
            onPressed: onPressed ?? () {},
            child: const Text('CONTAINED'),
          ),
          spacer,
          ElevatedButton.icon(
            onPressed: onPressed ?? () {},
            icon: icon,
            label: const Text('CONTAINED'),
          ),
          spacer,
          ElevatedButton.icon(
            onPressed: null,
            icon: icon,
            label: const Text('DISABLED'),
          ),
          spacer,
          OutlinedButton(
            onPressed: onPressed ?? () {},
            child: const Text('OUTLINED'),
          ),
          OutlinedButton.icon(
            onPressed: onPressed ?? () {},
            icon: icon,
            label: const Text('OUTLINED'),
          ),
          spacer,
          OutlinedButton.icon(
            onPressed: null,
            icon: icon,
            label: const Text('DISABLED'),
          ),
          spacer,
        ],
      ),
    );
  }
}

class ButtonDemo {
  const ButtonDemo({
    required this.title,
    required this.description,
    required this.builder,
  });

  final String title;
  final String description;
  final WidgetBuilder builder;
}

final List<ButtonDemo> allButtonDemos = <ButtonDemo>[
  ButtonDemo(
    title: 'Default Buttons',
    description:
        'Enabled and disabled buttons in their default configurations.',
    builder: (BuildContext context) => const DefaultButtons(),
  ),
  ButtonDemo(
    title: 'TextColor Buttons',
    description:
        'Use TextButtonTheme, ElevatedButtonTheme, OutlinedButtonTheme to '
        'override the text color of all buttons. The background color for '
        'ElevatedButtons does not change.',
    builder: (BuildContext context) => const TextColorButtons(),
  ),
  ButtonDemo(
    title: 'TextStyle Buttons',
    description: 'Use TextButtonTheme, ElevatedButtonTheme, '
        'OutlinedButtonTheme to override '
        'the default text style of the buttons. '
        'Press any button to toggle the text '
        'style size to an even bigger value.',
    builder: (BuildContext context) => const TextStyleButtons(),
  ),
  ButtonDemo(
    title: 'Individually Sized  Buttons',
    description: 'Sets the ButtonStyle parameter of '
        'individual buttons to override their '
        'default text style/ Press any button to toggle its text text style size.',
    builder: (BuildContext context) => const IndividuallySizedButtons(),
  ),
  ButtonDemo(
    title: 'Button Shapes',
    description:
        'Use TextButtonTheme, ElevatedButtonTheme, OutlinedButtonTheme to '
        'override the shape all buttons.',
    builder: (BuildContext context) => const ShapeButtons(),
  ),
  ButtonDemo(
    title: 'Dialog Buttons',
    description:
        'Use ButtonStyle to configure the shape of a dialog\'s action buttons.',
    builder: (BuildContext context) => const DialogButtons(),
  ),
];

class Home extends StatefulWidget {
  const Home({super.key, this.toggleThemeMode});

  final VoidCallback? toggleThemeMode;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage)
      ..addListener(pageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void pageChanged() {
    if (_pageController.hasClients) {
      setState(() {
        _currentPage = _pageController.page!.floor();
      });
    }
  }

  void changePage(int delta) {
    if (_pageController.hasClients) {
      const duration = Duration(milliseconds: 300);
      _pageController.animateToPage(
        _currentPage + delta,
        duration: duration,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final actionButtonStyle = TextButton.styleFrom(
      foregroundColor: colorScheme.onPrimary,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          allButtonDemos[_currentPage].title,
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        actions: <Widget>[
          TextButton(
            style: actionButtonStyle,
            onPressed: widget.toggleThemeMode,
            child: const Icon(Icons.stars),
          ),
          TextButton(
            style: actionButtonStyle,
            onPressed: () {
              changePage(-1);
            },
            child: const Icon(Icons.arrow_back),
          ),
          TextButton(
            style: actionButtonStyle,
            onPressed: () {
              changePage(1);
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: Container(
              height: 98,
              color: colorScheme.onSurface.withOpacity(0.1),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  allButtonDemos[_currentPage].description,
                  maxLines: 4,
                  style:
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: allButtonDemos.length,
              itemBuilder: (BuildContext context, int index) {
                return allButtonDemos[index].builder(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: const ColorScheme.light()),
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark()),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Home(
        toggleThemeMode: () {
          setState(() {
            _themeMode = _themeMode == ThemeMode.light
                ? ThemeMode.dark
                : ThemeMode.light;
          });
        },
      ),
    );
  }
}

void main() {
  runApp(const App());
}
