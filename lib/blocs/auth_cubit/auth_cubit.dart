import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:photo_gallery_assignment/injectable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late final _googleSignIn = getIt.get<GoogleSignIn>();

  AuthCubit() : super(const AuthInitial(null)) {
    _googleSignIn.signInSilently();
    _listenToAuthStateChange();
  }

  void _listenToAuthStateChange() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? currentUser) {
      print("new user ${currentUser?.email}");
      emit(AuthChanged(currentUser));
    });
  }

  void signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e, s) {
      print("signIn error $e $s");
    }
  }

  void signOut() {
    _googleSignIn.disconnect();
  }
}
