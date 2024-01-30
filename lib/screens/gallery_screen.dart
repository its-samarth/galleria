import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late List<String> images;
  int currentZoomLevel = 0;

  @override
  void initState() {
    super.initState();
    // Dummy image URLs
    images = List.generate(16, (index) => 'https://picsum.photos/id/$index/200/300');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Gallery')),
      body: GestureDetector(
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            // Adjusting zoom level based on scaling
            currentZoomLevel = details.scale.toInt();
          });
        },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(images[index], fit: BoxFit.cover);
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GalleryScreen(),
  ));
}
