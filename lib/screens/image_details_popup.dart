import 'package:flutter/material.dart';
import 'package:galleria/widgets/placeholder_widget.dart';

class ImageDetailsPopup extends StatelessWidget {
  final int index;

  ImageDetailsPopup({required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Image Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlaceholderWidget(), // Implement placeholder widget
          SizedBox(height: 8.0),
          Text('Title: Image $index'),
          Text('Author: John Doe'),
          Text('Description: Lorem ipsum...'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
