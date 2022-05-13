import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'extended_image_slide_page_route.dart';

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
    const imageUrl = 'https://avatars2.githubusercontent.com/u/1255062';
    return Scaffold(
      appBar: AppBar(
        title: const Text('extended_image'),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: GestureDetector(
            onTap: () => Navigator.of(context).push<void>(
              TransparentMaterialPageRoute(
                builder: (context) => const ImageDetailPage(
                  imageUrl: imageUrl,
                ),
              ),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: ExtendedImage.network(
                imageUrl,
                fit: BoxFit.cover,
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
    super.key,
    required this.imageUrl,
  });

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
            child: image,
          ),
        ),
      ),
    );
  }
}
