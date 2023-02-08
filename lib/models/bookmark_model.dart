import 'package:photo_gallery_assignment/models/photo_model.dart';

class BookmarkModel extends PhotoModel {
  final String id;

  BookmarkModel({required this.id, required super.url, required super.width, required super.height});
}
