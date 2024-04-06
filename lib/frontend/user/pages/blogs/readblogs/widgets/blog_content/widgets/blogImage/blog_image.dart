import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';

class BlogImage extends StatelessWidget {
  final BlogPosModel data;

  const BlogImage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 0.5,
          child: kIsWeb
              ? Image.network(
                  data.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Error loading image');
                  },
                )
              : CachedNetworkImage(
                  imageUrl: data.thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Text('Error loading image'),
                ),
        ),
      ),
    );
  }
}
