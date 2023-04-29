import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/Login/noverify_cubit.dart';
import '../network/repository/Repository.dart';
import '../screens/welcome.dart';

class LobbyPage extends StatefulWidget {
  static String route = 'lobby';

  LobbyPage({super.key, required this.title, required this.repository});

  Repository? repository;

  final String title;

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  @override
  Widget build(BuildContext context) {
    var repository;
    return Scaffold(
      body: BlocProvider(
        create: (context) => NoverifyCubit(repository: repository!),
        child: WelcomePage(),
      ),
    );
  }
}
