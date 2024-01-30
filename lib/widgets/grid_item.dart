import 'package:flutter/material.dart';
import 'package:galleria/screens/image_details_popup.dart';
import 'package:galleria/widgets/placeholder_widget.dart';

class GridItem extends StatelessWidget {
  final int index;

  GridItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageDetails(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[300],
        ),
        child: PlaceholderWidget(), // Implement placeholder widget
      ),
    );
  }

  void _showImageDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageDetailsPopup(index: index);
      },
    );
  }
}
