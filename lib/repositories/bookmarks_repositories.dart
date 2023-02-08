import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery_assignment/models/bookmark_model.dart';
import 'package:photo_gallery_assignment/models/photo_model.dart';
import 'package:uuid/uuid.dart';

abstract class BookmarksRepositoryProtocol {
  Future<List<BookmarkModel>?> getBookmarks(String userId);

  Future<String> saveBookmark(PhotoModel photoModel, String userId);

  Future<void> removeBookmark(BookmarkModel bookmarkModel, String userId);
}

@Injectable(as: BookmarksRepositoryProtocol)
class BookmarksRepository extends BookmarksRepositoryProtocol {
  final FirebaseDatabase firebaseDtb;

  BookmarksRepository(this.firebaseDtb);

  @override
  Future<List<BookmarkModel>?> getBookmarks(String userId) async {
    final ref = firebaseDtb.ref("$userId/bookmarks");
    final event = await ref.once();
    final values = event.snapshot.value as Map<dynamic, dynamic>;
    List<BookmarkModel> results = [];
    values.forEach((key, value) {
      results.add(BookmarkModel(
        id: key,
        url: value['url'],
        width: double.parse('${value['width']}'),
        height: double.parse('${value['height']}'),
      ));
    });
    return results;
  }

  @override
  Future<String> saveBookmark(PhotoModel photoModel, String userId) async {
    final ref = firebaseDtb.ref("$userId/bookmarks");
    final uuid = const Uuid().v1();
    await ref.child(uuid).set({"width": photoModel.width, "height": photoModel.height, "url": photoModel.url});
    return uuid;
  }

  @override
  Future<void> removeBookmark(BookmarkModel bookmarkModel, String userId) async {
    final ref = firebaseDtb.ref("$userId/bookmarks");
    await ref.child(bookmarkModel.id).remove();
  }
}
