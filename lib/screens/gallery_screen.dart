import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String>? images;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    images = List.generate(16, (index) => 'https://picsum.photos/id/$index/1200/1800');
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        loadMoreImages();
      }
    });
  }

  void loadMoreImages() {
    if (images != null) {
      List<String> additionalImages = List.generate(
        16,
        (index) => 'https://picsum.photos/id/${images!.length + index}/1200/1800',
      );
      setState(() {
        images!.addAll(additionalImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Gallery')),
      body: StaggeredGridView.builder(
        controller: scrollController,
        gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust as needed for full-screen display
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        ),
        itemCount: images?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (images != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenGallery(images: images!, initialIndex: index),
                  ),
                );
              }
            },
            child: CachedNetworkImage(
              imageUrl: images?[index] ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenGallery extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenGallery({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GalleryScreen(),
  ));
}
