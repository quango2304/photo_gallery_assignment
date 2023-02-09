import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_assignment/blocs/auth_cubit/auth_cubit.dart';
import 'package:photo_gallery_assignment/blocs/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:photo_gallery_assignment/models/bookmark_model.dart';
import 'package:photo_gallery_assignment/widgets/photo_list_widget.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final bookmarksBloc = BookmarksCubit();
  final paddingHorizontal = 16.0;

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthCubit>();
    bookmarksBloc.getBookmarks(authBloc.state.currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Bookmarks'),
          ),
          child: SafeArea(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: bookmarksBloc,
                ),
              ],
              child: BlocBuilder<BookmarksCubit, BookmarksState>(
                builder: (_, bookmarksState) {
                  final bookmarks = bookmarksState.bookmarks;
                  if (bookmarks.isEmpty) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return PhotoListWidget(
                    photos: bookmarks,
                    bookmarkIcon: (bookmark) => CupertinoButton(
                      onPressed: () {
                        bookmarksBloc.removeBookmark(bookmark as BookmarkModel, authState.currentUser!.id);
                      },
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.bookmark_remove,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    bookmarksBloc.close();
    super.dispose();
  }
}
