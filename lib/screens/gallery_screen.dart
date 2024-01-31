import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:galleria/widgets/loading_blur_overlay.dart';
import 'package:galleria/screens/full_screen_gallery.dart';
import 'package:galleria/main.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> images = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadImages();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadImages();
    }
  }

  void _loadImages() {
    // Increase the number of additional images to load as needed
    List<String> additionalImages = List.generate(
      20,
      (index) => 'https://picsum.photos/id/${images.length + index}/800/1200',
    );
    setState(() {
      images.addAll(additionalImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_4),
            onPressed: () {
              // Toggle between light and dark mode
              if (Theme.of(context).brightness == Brightness.light) {
                 MyApp.themeMode = ThemeMode.dark;
              } else {
                MyApp.themeMode = ThemeMode.light;
              }
              setState(() {});
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        controller: _scrollController,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenGallery(images: images, initialIndex: index),
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => LoadingBlurOverlay(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
