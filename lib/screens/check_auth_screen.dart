import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:photo_gallery_assignment/blocs/auth_cubit/auth_cubit.dart';
import 'package:photo_gallery_assignment/screens/photo_list_screen.dart';

class CheckAuthScreen extends StatefulWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  State createState() => CheckAuthScreenState();
}

class CheckAuthScreenState extends State<CheckAuthScreen> {
  final authCubit = AuthCubit();

  Widget _buildBody() {
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
              child: ElevatedButton(
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
    return BlocProvider.value(
      value: authCubit,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }
}