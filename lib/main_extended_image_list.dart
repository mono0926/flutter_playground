import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'extended_image_slide_page_route.dart';

void main() => runApp(const App());

final _urls = List.generate(
  50,
  (index) => 'https://storage.googleapis.com/debug-mono/${index % 5 + 1}.jpg',
);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('extended_image'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: _urls.length,
        itemBuilder: (context, index) {
          final url = _urls[index];
          return Hero(
            tag: index,
            key: ValueKey(url),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Ink.image(
                image: ExtendedNetworkImageProvider(url),
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () => Navigator.of(context).push<void>(
                    TransparentMaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => _ImagesPage(
                        initialIndex: index,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ImagesPage extends StatefulWidget {
  const _ImagesPage({
    required this.initialIndex,
  });

  final int initialIndex;

  @override
  __ImagesPageState createState() => __ImagesPageState();
}

class __ImagesPageState extends State<_ImagesPage> {
  late final _pageController = ExtendedPageController(
    initialPage: widget.initialIndex,
  );
  late final int _index;

  @override
  void initState() {
    super.initState();

    _index = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text('${_index + 1} / ${_urls.length}'),
        ),
        SizedBox(height: 1 / MediaQuery.of(context).devicePixelRatio),
        Expanded(
          child: ExtendedImageSlidePage(
            child: ExtendedImageGesturePageView.builder(
              controller: _pageController,
              itemCount: _urls.length,
              onPageChanged: (index) => setState(() => _index = index),
              itemBuilder: (context, index) {
                final url = _urls[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: ExtendedImage.network(
                    url,
                    fit: BoxFit.contain,
                    enableSlideOutPage: true,
                    mode: ExtendedImageMode.gesture,
                    heroBuilderForSlidingPage: (image) => Hero(
                      tag: index,
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
