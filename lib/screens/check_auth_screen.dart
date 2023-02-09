import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_assignment/blocs/auth_cubit/auth_cubit.dart';
import 'package:photo_gallery_assignment/screens/photo_list_screen.dart';

class CheckAuthScreen extends StatefulWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  State createState() => CheckAuthScreenState();
}

class CheckAuthScreenState extends State<CheckAuthScreen> {
  Widget _buildBody() {
    final authCubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(builder: (_, authState) {
      final user = authState.currentUser;
      if (user != null) {
        return const PhotoListScreen();
      } else {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Sign in screen'),
          ),
          child: SafeArea(
            child: Center(
              child: CupertinoButton.filled(
                onPressed: () => authCubit.signIn(),
                child: const Text('SIGN IN WITH GOOGLE'),
              ),
            ),
          ),
        );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    );
  }
}