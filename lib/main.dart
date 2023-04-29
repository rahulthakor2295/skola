import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skola/component/color.dart';
import 'package:skola/data/Login/noverify_cubit.dart';
import 'package:skola/router_page/route.dart';
import 'package:skola/screens/homescreen/home%20screen.dart';
import 'package:skola/screens/login_page/login.dart';
import 'package:skola/screens/welcome.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'network/repository/Repository.dart';
import 'package:get/get.dart';

var mAuth = FirebaseAuth.instance;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xFF089920)));
  WidgetsFlutterBinding.ensureInitialized();
// set this to remove reCaptcha web

//   mAuth.getFirebaseAuthSettings().setAppVerificationDisabledForTesting(true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Repository? repository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoverifyCubit(repository: repository),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            accentColor: Color(0xFF089920),
            scaffoldBackgroundColor: Color(0xFFF6FCFF),
            backgroundColor: Color(0xFFF6FCFF),
            buttonColor: Componant.commnColor,
            appBarTheme: AppBarTheme(color: Color(0xFF089920))),
        debugShowCheckedModeBanner: false,
        initialRoute: LobbyPage.route,
        routes: {
          LobbyPage.route: (context) =>
              LobbyPage(title: "", repository: repository)
        },
      ),
    );
  }
}
