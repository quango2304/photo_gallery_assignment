part of 'photo_cubit.dart';

abstract class PhotosState extends Equatable {
  final List<PhotoModel> photos;
  const PhotosState(this.photos);
  @override
  List<Object?> get props => [photos.length];
}

class PhotosLoaded extends PhotosState {
  const PhotosLoaded(super.photos);
}

class PhotosLoading extends PhotosState {
  const PhotosLoading(super.photos);
}

class PhotosInitial extends PhotosState {
  const PhotosInitial(super.photos);
}

