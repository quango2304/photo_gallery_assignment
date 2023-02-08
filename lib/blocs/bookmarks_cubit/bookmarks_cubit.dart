import 'package:bloc/bloc.dart';
import 'package:photo_gallery_assignment/injectable.dart';
import 'package:photo_gallery_assignment/models/bookmark_model.dart';
import 'package:photo_gallery_assignment/models/photo_model.dart';
import 'package:photo_gallery_assignment/repositories/bookmarks_repositories.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit() : super(const BookmarksInitial([]));

  BookmarksRepositoryProtocol get photoRepository => getIt.get<BookmarksRepositoryProtocol>();

  void getBookmarks(String userId) async {
    final bookmarks = await photoRepository.getBookmarks(userId);
    emit(BookmarksUpdated(bookmarks ?? []));
  }

  void saveBookmark(PhotoModel photo, String userId) async {
    final bookMarkId = await photoRepository.saveBookmark(photo, userId);
    emit(BookmarksUpdated(
        [...state.bookmarks, BookmarkModel(url: photo.url, width: photo.width, height: photo.height, id: bookMarkId)]));
  }

  void removeBookmark(BookmarkModel bookmarkModel, String userId) async {
    await photoRepository.removeBookmark(bookmarkModel, userId);
    emit(BookmarksUpdated(state.bookmarks..removeWhere((element) => element.id == bookmarkModel.id)));
  }
}
