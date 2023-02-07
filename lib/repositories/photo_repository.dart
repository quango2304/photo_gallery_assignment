import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:photo_gallery_assignment/models/photo_model.dart';

abstract class PhotoRepositoryProtocol {
  Future<List<PhotoModel>> loadPhotos(int page, int limit);
}

class PhotoRepository extends PhotoRepositoryProtocol {
  @override
  Future<List<PhotoModel>> loadPhotos(int page, int limit) async {
    List<PhotoModel> results = [];
    final url = 'https://picsum.photos/v2/list?page=$page&limit=$limit';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as List;
    results.addAll(data.map((item) {
      return PhotoModel.fromMap(item);
    }));
    print("load photos form url: $url and got ${results.length} photos");
    return results;
  }
}
