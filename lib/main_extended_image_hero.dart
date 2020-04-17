import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

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
    const imageUrl = 'https://avatars2.githubusercontent.com/u/1255062';
    return Scaffold(
      appBar: AppBar(
        title: const Text('extended_image'),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: GestureDetector(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: ExtendedImage.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () => Navigator.of(context).push<void>(
              TransparentMaterialPageRoute(
                builder: (context) => const ImageDetailPage(
                  imageUrl: imageUrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ExtendedImageSlidePage(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: ExtendedImage.network(
          imageUrl,
          fit: BoxFit.contain,
          enableSlideOutPage: true,
          mode: ExtendedImageMode.gesture,
          heroBuilderForSlidingPage: (image) => Hero(
            tag: imageUrl,
            child: image,
            flightShuttleBuilder: (
              flightContext,
              animation,
              flightDirection,
              fromHeroContext,
              toHeroContext,
            ) {
              final hero = (flightDirection == HeroFlightDirection.pop
                  ? fromHeroContext.widget
                  : toHeroContext.widget) as Hero;
              return hero.child;
            },
          ),
        ),
      ),
    );
  }
}
