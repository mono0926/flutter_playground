import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider(create: (context) => GlobalKey<NavigatorState>()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: context.read(),
      home: ChangeNotifierProvider(
        create: (context) => Model(
          locator: context.read,
        ),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return Scaffold(
      key: model.scaffoldKey,
      appBar: AppBar(title: const Text('Key Sample')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Navigation'),
            onTap: model.push,
          ),
          ListTile(
            title: const Text('Alert Dialog'),
            onTap: model.showAlertDialog,
          ),
          ListTile(
            title: const Text('SnackBar'),
            onTap: model.showSnackBar,
          ),
        ],
      ),
    );
  }
}

class Model with ChangeNotifier {
  Model({
    @required this.locator,
  });
  final Locator locator;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<NavigatorState> get _navigatorKey => locator();
  void push() {
    _navigatorKey.currentState.push<void>(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Next Page'),
          ),
        ),
      ),
    );
  }

  void showAlertDialog() {
    showDialog<void>(
      context: scaffoldKey.currentContext,
      builder: (context) => const AlertDialog(
        title: Text('Alert Dialog'),
      ),
    );
  }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(
      const SnackBar(
        content: Text('SnackBar'),
      ),
    );
  }
}
