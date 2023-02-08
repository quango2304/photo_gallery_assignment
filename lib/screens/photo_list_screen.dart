import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:photo_gallery_assignment/blocs/auth_cubit/auth_cubit.dart';
import 'package:photo_gallery_assignment/blocs/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:photo_gallery_assignment/blocs/photo_cubit/photo_cubit.dart';
import 'package:photo_gallery_assignment/screens/bookmarks_screen.dart';
import 'package:photo_gallery_assignment/widgets/photo_list_widget.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({Key? key}) : super(key: key);

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  final photosBloc = PhotoCubit();
  final bookmarksBloc = BookmarksCubit();
  late final ScrollController controller;
  final paddingHorizontal = 16.0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    photosBloc.loadPhotos();
  }

  void _showUserInfoActionSheet(GoogleSignInAccount user) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text('${user.displayName}'),
        message: Text(user.email),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthCubit>().signOut();
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _showUserInfoActionSheet(authState.currentUser!);
                },
                child: const Text('Account')),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text(
                'Bookmarks',
              ),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const BookmarksScreen()));
              },
            ),
          ),
          child: SafeArea(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: photosBloc,
                ),
                BlocProvider.value(
                  value: bookmarksBloc,
                ),
              ],
              child: BlocBuilder<PhotoCubit, PhotosState>(
                builder: (_, photosState) {
                  final photos = photosState.photos;
                  if (photos.isEmpty) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return PhotoListWidget(
                    controller: controller,
                    photos: photos,
                    onPressBookMark: (photo) {
                      bookmarksBloc.saveBookmark(photo, authState.currentUser!.id);
                    },
                  );
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
    bookmarksBloc.close();
    super.dispose();
  }
}
