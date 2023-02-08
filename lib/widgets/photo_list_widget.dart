import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery_assignment/models/photo_model.dart';
import 'package:photo_gallery_assignment/screens/photo_detail_screen.dart';

class PhotoListWidget extends StatelessWidget {
  final ScrollController? controller;
  final paddingHorizontal = 16.0;
  final List<PhotoModel> photos;
  final Widget Function(PhotoModel photoModel) bookmarkIcon;

  const PhotoListWidget({Key? key, this.controller, required this.photos, required this.bookmarkIcon})
      : super(key: key);

  void _gotoPhotoDetailView(PhotoModel photo, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PhotoDetailScreen(
              photo: photo,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingHorizontal),
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      itemBuilder: (_, index) {
        final photo = photos[index];
        final photoRealWidth = MediaQuery.of(context).size.width - paddingHorizontal * 2;
        final photoRealHeight = photo.height * photoRealWidth / photo.width;
        return GestureDetector(
          onTap: () {
            _gotoPhotoDetailView(photo, context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: photo.url,
                  width: photoRealWidth,
                  height: photoRealHeight,
                  placeholder: (context, url) {
                    return buildPlaceHolderForPhoto(photoRealWidth, photoRealHeight);
                  },
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: bookmarkIcon(photo),
                )
              ],
            ),
          ),
        );
      },
      itemCount: photos.length,
    );
  }

  FadeShimmer buildPlaceHolderForPhoto(double photoRealWidth, double photoRealHeight) {
    return FadeShimmer(
      width: photoRealWidth,
      height: photoRealHeight,
      radius: 16,
      highlightColor: Colors.grey.withOpacity(0.1),
      baseColor: Colors.grey.withOpacity(0.5),
    );
  }
}
