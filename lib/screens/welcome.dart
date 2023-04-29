import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skola/component/color.dart';
import 'package:skola/data/Login/noverify_cubit.dart';
import 'package:skola/network/repository/Repository.dart';
import 'package:skola/network/api_client/ApiClient.dart';
import 'package:skola/screens/login_page/login.dart';

import 'apiresponse.dart';
import 'homescreen/home screen.dart';
import 'login_page/otp.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);
  late Repository? repository;

  @override
  State<WelcomePage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<WelcomePage> {
  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiClient apiClient = ApiClient(Dio());
    Repository repository = Repository(apiClient: apiClient);
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          NoverifyCubit(repository: repository),
                      child: LoginPage(
                        repository: repository,
                      ),
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF83D475),
              Color(0xFF57C84D),
              Color(0xFF2EB62C),
              Color(0xFF3B9403),
              Color(0xFF3B9403),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.all(130.0),
            child: Image(
              height: 100.0,
              width: 100.0,
              image: AssetImage("assets/Images/ic.png.png"),
            ),
          ),
        ),
      ),
    );
  }
}
