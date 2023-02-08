part of 'bookmarks_cubit.dart';

abstract class BookmarksState {
  final List<BookmarkModel> bookmarks;

  const BookmarksState(this.bookmarks);
}

class BookmarksInitial extends BookmarksState {
  const BookmarksInitial(super.bookmarks);
}

class BookmarksUpdated extends BookmarksState {
  const BookmarksUpdated(super.bookmarks);
}
