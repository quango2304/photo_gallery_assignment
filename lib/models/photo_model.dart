class PhotoModel {
  final String url;
  final double width;
  final double height;

  PhotoModel({required this.url, required this.width, required this.height});

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
        url: map['download_url'], width: double.parse('${map['width']}'), height: double.parse('${map['height']}'));
  }
}
