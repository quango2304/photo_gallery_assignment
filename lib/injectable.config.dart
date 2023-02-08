// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_database/firebase_database.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:photo_gallery_assignment/repositories/bookmarks_repositories.dart'
    as _i6;
import 'package:photo_gallery_assignment/repositories/photo_repository.dart'
    as _i5;

import 'injectable.dart' as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.FirebaseDatabase>(() => registerModule.firebaseDatabase);
    gh.lazySingleton<_i4.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.factory<_i5.PhotoRepositoryProtocol>(() => _i5.PhotoRepository());
    gh.factory<_i6.BookmarksRepositoryProtocol>(
        () => _i6.BookmarksRepository(gh<_i3.FirebaseDatabase>()));
    return this;
  }
}

class _$RegisterModule extends _i7.RegisterModule {}
