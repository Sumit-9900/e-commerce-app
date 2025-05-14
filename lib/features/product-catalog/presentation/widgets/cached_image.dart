import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  const CachedImage({super.key, required this.imageUrl, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: height,
        width: double.infinity,
        placeholder: (context, url) => Container(color: Colors.grey),
        errorWidget:
            (context, url, error) => Container(
              color: Colors.grey,
              child: Column(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  const SizedBox(height: 3),
                  Text('Unable to fetch data!'),
                ],
              ),
            ),
      ),
    );
  }
}
