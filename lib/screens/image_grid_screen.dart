import 'package:flutter/material.dart';
import 'package:galleria/widgets/grid_item.dart';

class ImageGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Gallery')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemCount: 16,
        itemBuilder: (BuildContext context, int index) {
          return GridItem(index: index);
        },
      ),
    );
  }
}
