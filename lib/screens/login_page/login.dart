import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skola/component/color.dart';
import 'package:skola/data/Login/noverify_cubit.dart';
import 'package:skola/data/optscreen/otp_cubit.dart';
import 'package:skola/network/repository/Repository.dart';
import 'package:skola/network/api_client/ApiClient.dart';
import 'package:skola/screens/homescreen/home%20screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skola/screens/login_page/otp.dart';

import '../../main.dart';
import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../apiresponse.dart';
// import { getAuth, signInWithPhoneNumber } from "firebase/auth";

class LoginPage extends StatefulWidget {
  late Repository repository;
  static String route = 'lobby';

  LoginPage({Key? key, required this.repository}) : super(key: key);
  static String VARIFY = "";
  static String sharedname = '';
  final TextEditingController countryController = TextEditingController();
  LoginResponse? user;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const KTextFieldWidth = 3.0;
  var phone = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController countryController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController sharedText = TextEditingController();
  FocusNode? _focusEmail;
  FocusNode? _focusPassword;
  var noVerifyCubit;
  var loginKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final String app = 'school';
  static String KEYNAME = 'user';
  bool _isShow = false;

  // / static const    String?   KEYNAME = "name";
  // var nameValue = "";

  // @override
  // void initState() {
  //
  //   super.initState();
  //   getData();
  // }
  // @override
  // void initState() {
  //   countryController.text = "+91";
  //   super.initState();
  // }
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    noVerifyCubit = context.read<NoverifyCubit>();
    super.initState();
  }

  // bool? visible = false;

  // loadProgress() {
  //   if (_isShow == true) {
  //     Timer(Duration(microseconds: 30000));
  //     setState(()
  //       visible = false;
  //     });
  //   } else {
  //     setState(() {
  //       visible = true;
  //     });
  //   }
  // }

  void isShowNot() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isShow = true;
      });
    });
  }

  void isShow() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isShow = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Text(
                "Enter your mobile number to verify",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Images/ic.png.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Center(
                child: Form(
                  key: loginKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.green, width: 4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    child: Text(
                                      "+91",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black38),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 275,
                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                      // borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "Number shuld not be Empty")));
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.phone,
                                      // onChanged: (value) {
                                      //   phone = value;
                                      // },
                                      controller: countryController,
                                      decoration: InputDecoration(
                                        // enabledBorder: UnderlineInputBorder(
                                        //   borderSide: BorderSide(
                                        //       color: Componant.commnColor,
                                        //       width: KTextFieldWidth),
                                        // ),
                                        // focusedBorder: UnderlineInputBorder(
                                        //   borderSide: BorderSide(
                                        //       color: Componant.commnColor,
                                        //       width: KTextFieldWidth),
                                        // ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Enter mobile no",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // TextFormField(
                          //   controller: _emailController,
                          //   decoration: InputDecoration(
                          //       enabledBorder: UnderlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Componant.commnColor,
                          //             width: KTextFieldWidth),
                          //       ),
                          //       focusedBorder: UnderlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Componant.commnColor,
                          //             width: KTextFieldWidth),
                          //       ),
                          //       hintText: "paasword",
                          //       border: InputBorder.none),
                          // ),
                          Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              // child: GestureDetector(
                              //   onTap: () {
                              //     sendOtp();
                              //   },
                              //   child: Container(
                              //     height: 40.0,
                              //     width: double.infinity,
                              //     decoration:
                              //         BoxDecoration(color: Componant.commnColor),
                              //     child: Center(
                              //       child: Text(
                              //         "Login",
                              //         style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 20.0,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // ),
                              child: BlocConsumer<NoverifyCubit, NoverifyState>(
                                listener: (context, state) {
                                  if (state is NoverifyLoadingState) {
                                    print("Loading....");
                                  } else if (state is NoverifySuccessState) {
                                    if (state.response.error == false) {
                                      setState(() {
                                        loginPage?.user = state.response;
                                        sendOtp();
                                        // LoginPage.sharedname =
                                        //     state.response as String;
                                      });
                                    } else {
                                      print("not valid ====> ");
                                    }
                                  } else if (state is NoverifyErrorState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.error)));
                                  }
                                },
                                builder: (context, state) {
                                  return Visibility(
                                    visible: !_isShow,
                                    replacement: CircularProgressIndicator(
                                      color: Componant.commnColor,
                                    ),
                                    child: MaterialButton(
                                      onPressed: () async {
                                        // setState(() {
                                        //   visible = false;
                                        // });;
                                        if (_isShow = !_isShow) {
                                          setState(() {
                                            Future.delayed(
                                                Duration(milliseconds: 23000),
                                                () {
                                              setState(() {
                                                _isShow = !_isShow;
                                              });
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            Future.delayed(Duration(seconds: 3),
                                                () {
                                              setState(() {
                                                _isShow == _isShow;
                                              });
                                            });
                                          });
                                        }

                                        if (loginKey.currentState!.validate()) {
                                          print('if-----------------');
                                          // setState(() {
                                          //   _isShow = !_isShow;
                                          // });
                                          var pref = await SharedPreferences
                                              .getInstance();
                                          pref.setString(
                                              KEYNAME, LoginPage.sharedname);
                                          noVerifyCubit.Noverify(
                                              countryController.text, app);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Empty')),
                                          );
                                        }

                                        //
                                        // await Future.delayed(
                                        //     const Duration(seconds: 5));
                                        // setState(() {
                                        //   isLoading = false;
                                        // });
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      minWidth: 320.0,
                                      color: Componant.commnColor,
                                    ),
                                  );
                                },
                              )),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //       shape: StadiumBorder()),
                          //   onPressed: () async {
                          //     setState(() {
                          //       isLoading = true;
                          //     });
                          //     await Future.delayed(const Duration(seconds: 5));
                          //     setState(() {
                          //       isLoading = false;
                          //     });
                          //   },
                          //   child: (isLoading)
                          //       ? const SizedBox(
                          //       width: 16,
                          //       height: 16,
                          //       child: CircularProgressIndicator(
                          //         color: Colors.white,
                          //         strokeWidth: 1.5,
                          //       ))
                          //       : const Text('Submit'),
                          // ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       sendOtp();
                          //     },
                          //     child: Text('press'))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getprefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    // Post? jsonString;
    // List<String> json = jsonDecode(jsonString as String);
    // String? user = jsonEncode(Post.fromJson(json as Map<String, dynamic>));
    // pref.setString(KEYNAME, user);
    var getName = prefs.getString(
      KEYNAME,
    );
    LoginPage.sharedname = getName ?? "NO value";
    // SharedPreferences pref = await SharedPreferences.getInstance();
  }

  // void getdata() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   List json = jsonDecode(pref.getString(KEYNAME).toString());
  //   var user = Post.fromJson(json as Map<String, dynamic>);
  //   LoginPage.sharedname = user as String;
  //   setState(() {});
  // }
  LoginPage? loginPage;

  void sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      // phoneNumber: '+919664997325',
      phoneNumber: "+91${countryController.text.trim()}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verificationdfailed${e}');
      },
      codeSent: (String verificationId, int? resendToken) {
        print('codesent');
        // String no = "+91" + countryController.text.trim().toString();
        // String otpno = countryController.text.trim().toString();
        // print("sendnumber" + otpno);
        LoginPage.VARIFY = verificationId;
        print("${widget.countryController.toString()}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          OtpCubit(repository: widget.repository),
                      child: OptVarified(
                          repository: widget.repository,
                          verificationId: LoginPage.VARIFY,
                          number: countryController.text),
                    )));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('codeAutoRetrievalTimeout');
      },
    );
  }
}
// Future<Post?> getPostApiCall() async {
//   final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
//   Map<String, String> createDoc = new HashMap();
//   createDoc['mobile'] = "9924226515";
//   createDoc['app'] = "school";
//   // final response = client.getLogin('123','abc','',createDoc);
//   final response = client.noVerify(countryController.text);
//   final user = postFromJson(response.toString());
//   print(user);
// }
// Future NoVerify() async {
//   final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
//   Map<String, dynamic> createDoc = new HashMap();
//   createDoc['mobile'] = countryController.text;
//   createDoc['app'] = 'school';
//   final response = client.OtpVerification(countryController.text as String);
// }

// Future<ApiResponse> login(String email, String pass) async {
//   ApiResponse _apiResponse = ApiResponse();
//
//   try {
//     print("2295");
//     final response = await http.post(
//         'http://school.paperbirdtech.com/api/Teacher/login.php' as Uri,
//         body: {
//           'username': email,
//           'password': pass,
//         });
//
//     switch (response.statusCode) {
//       case 200:
//         var data =
//             _apiResponse.Data = User.fromJson(json.decode(response.body));
//         print("1188=====>$data");
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => HomePage()));
//
//         break;
//       case 401:
//         print("401");
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("401")));
//
//         break;
//       default:
//         print("402");
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("wrong end")));
//         break;
//     }
//   } on SocketException {
//     print("so");
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("server error")));
//   }
//   return _apiResponse;
// }

// ApiResponse _apirespose = ApiResponse();
// // User user = User();
// if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
//   var response  =  await http.post(Uri.parse("http://school.paperbirdtech.com/api/Teacher/login.php"),body: ({
//     'username': email,
//     'password': pass,
//   }));
//
//   if(response.statusCode == 200){
//     var data = _apirespose.Data = User.fromJson(jsonDecode(response.body.toString()));
//     print("1188=> $data");
//
//
//     // var name = data.name;
//     // var pref = await SharedPreferences.getInstance();
//     // pref.setString(KEYNAME!, name!);
//
//     // print(data.name);
//     Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Success")));
//   }else{
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong pleasetry agian ")));
//   }
// }
//
// else {
//   ScaffoldMessenger.of(context).
//   showSnackBar(SnackBar(content: Text("wrong")));
// }

// void getData() async{
//   var pre =  await SharedPreferences.getInstance();
//
//   var getName=  pre.getString(KEYNAME!);
//   setState(() {
//     nameValue = getName ?? "NO value";
//   });

// FutureBuilder(
//   future: _initializeFirebase(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.done) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 30.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _emailController,
//                 focusNode: _focusEmail,
//                 validator: (value) =>
//                     Validator.validateEmail(email: value.toString()),
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   hintText: 'Enter your Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.cicolorrcular(20.0),
//                     borderSide: BorderSide(: Colors.teal),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 focusNode: _focusPassword,
//                 validator: (value) => Validator.validatePassword(
//                     password: value.toString()),
//                 decoration: InputDecoration(
//                   labelText: 'password',
//                   hintText: 'Enter your passsword',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.teal),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Container(
//                 width: 130.0,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50.0)),
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       User? user =
//                           await FireAuth.signInUsingEmailPassword(
//                         email: _emailController.text,
//                         password: _passwordController.text,
//                       );
//                       if (user != null) {
//                         Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   ProfilePage(user: user)),
//                         );
//                       }
//                     }
//                   },
//                   child: Text(
//                     'Sign In',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => RegisterPage2()),
//                   );
//                 },
//                 child: Text(
//                   'register here',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   },
// )
// return Scaffold(
//     body: Single               ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,ChildScrollView(
//     child: Container(
//     child: Column(
//     children: <Widget>[
//     Container(
//     height: 350.0,
//     decoration: BoxDecoration(
//     image: DecorationImage(
//     image: AssetImage('assets/Images/background.png'),
// fit: BoxFit.fill),
// ),
// child: Stack(
// children: <Widget>[
// Positioned(
// left: 30.0,
// width: 80.0,
// height: 180.0,
// child: Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage('assets/Images/light-1.png'),
// ),
// ),
// )),
// Positioned(
// left: 140.0,
// width: 90.0,
// height: 140,
// child: Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage('assets/Images/light-2.png'),
// ),
// ),
// ),
// ),
// Positioned(
// right: 40.0,
// top: 20.0,
// width: 90.0,
// height: 170.0,
// child: Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage("assets/Images/clock.png"),
// ),
// ),
// ),
// ),
// Positioned(
// top: 190.0,
// left: 150.0,
// child: Container(
// child: Center(
// child: Text(
// "Login",
// style: TextStyle(
// fontSize: 40.0,
// fontWeight: FontWeight.bold,
// color: Colors.white),
// ),
// ),
// )),
// Padding(
// padding: const EdgeInsets.all(30.0),
// child: Column(
// children: [
// Container(
// decoration: BoxDecoration(color: Colors.grey),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 50.0,left:10.0 , right:10.0),
// child: Positioned(
// child: Column(
// children: [
// Container(
//
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// offset: Offset(0.0, 10.0),
// blurRadius: 20.0,
// color: Color.fromRGBO(143, 148, 251, 1)),
// ],
// color: Colors.white,
// borderRadius: BorderRadius.circular(5.0),
// ),
// child: Column(
// children: [
// Center(
// child: Padding(
// padding: const EdgeInsets.only(top: 10.0),
// child: TextFormField(
// controller: _emailController,
// decoration: InputDecoration(
// hintText: " Enter your Email ",
// border: InputBorder.none),
// ),
// ),
// ),
// SizedBox(
// height: 10.0,
// ),
// Center(
// child: Padding(
// padding: const EdgeInsets.only(left: 10.0),
// child: TextFormField(
// controller: _passwordController,
// decoration: InputDecoration(
// hintText: "Enter your Password",
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// SizedBox(
// height: 30.0,
// ),
// Container(
// height: 240.0,
// decoration: BoxDecoration(
//
// borderRadius: BorderRadius.circular(10.0),
// gradient: LinearGradient(
// colors: [Color.fromRGBO(143, 148, 251, 1)])),
// ),
// Padding(
// padding: const EdgeInsets.only(bottom: 10.0),
// child: ElevatedButton(onPressed: () async {login(_emailController.text , _passwordController.text);}, child: Text(
// "Login"), style: ButtonStyle(
// backgroundColor: MaterialStateProperty.all(
// Color.fromRGBO(143, 148, 251, 1)),
// foregroundColor: MaterialStateProperty.all(
// Colors.white),
// shape: MaterialStateProperty.all(
// RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// side: MaterialStateBorderSide.resolveWith((
// states) =>
// BorderSide(color: Colors.white
// )),),),),),
// ),
// // Text("name=======> $nameValue)"),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// ),);
