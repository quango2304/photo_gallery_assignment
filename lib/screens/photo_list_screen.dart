import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_assignment/blocs/auth_cubit/auth_cubit.dart';
import 'package:photo_gallery_assignment/blocs/photo_cubit/photo_cubit.dart';
import 'package:photo_gallery_assignment/widgets/photo_list_widget.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({Key? key}) : super(key: key);

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  final photosBloc = PhotoCubit();
  late final ScrollController controller;
  final paddingHorizontal = 16.0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()
      ..addListener(_scrollListener);
    photosBloc.loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: Text('${authState.currentUser?.email}'),
            trailing: GestureDetector(
              child: const Text('Sign out', style: TextStyle(color: Colors.blue),),
              onTap: () {
                context.read<AuthCubit>().signOut();
              },
            ),
          ),
          child: SafeArea(
            child: BlocProvider.value(
              value: photosBloc,
              child: BlocBuilder<PhotoCubit, PhotosState>(
                builder: (_, photosState) {
                  final photos = photosState.photos;
                  if (photos.isEmpty) {
                    return const Text("Loading your photo");
                  }
                  return PhotoListWidget(controller: controller, photos: photos,);
                },
              ),
            ),
          ),
        );
      },
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
