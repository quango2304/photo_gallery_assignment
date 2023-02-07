import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_gallery_assignment/models/photo_model.dart';
import 'package:photo_gallery_assignment/repositories/photo_repository.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotosState> {
  final PhotoRepositoryProtocol photoRepository;
  static const limit = 20;
  bool canLoadMore = true;
  int currentPage = 0;

  PhotoCubit(this.photoRepository) : super(const PhotosInitial([]));

  void loadPhotos() async {
    if (state is PhotosLoading || canLoadMore == false) {
      return;
    }
    try {
      emit(PhotosLoading(state.photos));
      final photos = await photoRepository.loadPhotos(currentPage, limit);
      _addPhotos(photos);
      if (photos.length < limit) {
        canLoadMore = false;
      }
    } catch (e, s) {
      print("error when load photos $e $s");
    }
  }

  void _addPhotos(List<PhotoModel> newPhotos) {
    currentPage++;
    List<PhotoModel> currentPhotos = state.photos;
    emit(PhotosLoaded([...currentPhotos, ...newPhotos]));
  }
}
