// services/gallery_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gallery_item.dart';

class GalleryService {
  static Future<List<GalleryItem>> fetchGalleryItems() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos?_limit=16'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => GalleryItem(id: item['id'], imageUrl: item['url'])).toList();
    } else {
      throw Exception('Failed to load gallery items');
    }
  }
}
