import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_assignment/blocs/photo_cubit.dart';
import 'package:photo_gallery_assignment/repositories/photo_repository.dart';
import 'package:photo_gallery_assignment/screens/photo_detail_screen.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final photosBloc = PhotoCubit(PhotoRepository());
  late final ScrollController controller;
  final paddingHorizontal = 16.0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    photosBloc.loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Photo gallery'),
      ),
      child: SafeArea(
        child: BlocProvider.value(
          value: photosBloc,
          child: BlocBuilder<PhotoCubit, PhotosState>(
            builder: (_, state) {
              final photos = state.photos;
              if (photos.isEmpty) {
                return const Text("Loading your photo");
              }
              return ListView.separated(
                controller: controller,
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingHorizontal),
                separatorBuilder: (_, __) => const SizedBox(
                  height: 5,
                ),
                itemBuilder: (_, index) {
                  //render a loading widget at the last item
                  if (index == photos.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final photo = photos[index];
                  final photoRealWidth = MediaQuery.of(context).size.width - paddingHorizontal * 2;
                  final photoRealHeight = photo.height * photoRealWidth / photo.width;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PhotoDetailScreen(
                                photo: photo,
                              )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
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
                  );
                },
                itemCount: photos.length + 1,
              );
            },
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 800) {
      photosBloc.loadPhotos();
    }
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    photosBloc.close();
    super.dispose();
  }
}
