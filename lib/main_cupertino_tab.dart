import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              navigationBar: AppBarWrapper(
                child: AppBar(
                  title: const Text('Hello'),
                ),
              ),
              child: Center(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute<void>(
                        builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text('Page 2 of tab $index'),
                            ),
                            body: Center(
                              child: CupertinoButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Back'),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Next page'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AppBarWrapper extends PreferredSize with ObstructingPreferredSizeWidget {
  AppBarWrapper({
    super.key,
    required super.child,
  }) : super(
          preferredSize: const Size.fromHeight(kToolbarHeight),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Hello'),
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
