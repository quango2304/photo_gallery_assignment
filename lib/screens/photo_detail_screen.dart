import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery_assignment/models/photo_model.dart';

class PhotoDetailScreen extends StatefulWidget {
  final PhotoModel photo;
  const PhotoDetailScreen({Key? key, required this.photo}) : super(key: key);

  @override
  State<PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final photo = widget.photo;
    final photoRealWidth = MediaQuery.of(context).size.width;
    final photoRealHeight = photo.height * photoRealWidth / photo.width;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Photo detail'),
      ),
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: photo.url,
              width: photoRealWidth,
              height: photoRealHeight,
              placeholder: (context, url) {
                return FadeShimmer(
                  width: photoRealWidth,
                  height: photoRealHeight,
                  radius: 16,
                  highlightColor: Colors.grey.withOpacity(0.1),
                  baseColor: Colors.grey.withOpacity(0.5),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
