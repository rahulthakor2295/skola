import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skola/data/optscreen/otp_cubit.dart';
import 'package:skola/network/repository/Repository.dart';
import 'package:skola/network/api_client/ApiClient.dart';
import 'package:skola/screens/homescreen/home%20screen.dart';
import 'package:skola/screens/login_page/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../component/color.dart';
import '../../data/Login/noverify_cubit.dart';
import '../../network/entity/LoginResponse/LoginResponse.dart';

class OptVarified extends StatefulWidget {
  static String route = 'lobby';
  String? number;
  String? verificationId;
  static String sharedname = "";
  Repository repository;
  SharedPreferences? sharedPreferences;

  OptVarified(
      {Key? key,
      required String verificationId,
      required String number,
      required this.repository}) {
    this.number = number;
    this.verificationId = verificationId;
  }

  @override
  State<OptVarified> createState() => _OptVarifiedState();
}

class _OptVarifiedState extends State<OptVarified> {
  // LoginResponse? user;

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  bool _isShow = false;
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;
  bool _timeShow = true;

  bool indicator = false;

  void starTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        setState(() {
          indicator = false;
        });
        timer.cancel();
      }
    });
  }

  Widget buildTimer() {
    return Text(
      "00:${seconds}",
      style: TextStyle(fontSize: 20.0),
    );
  }

  void ResendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${widget.number?.trim()}",
      verificationCompleted: (PhoneAuthCredential credential) {
        print("verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verificationdfailed');
      },
      codeSent: (String verificationId, int? resendToken) {
        print('codesent');
        // String no = "+91" + countryController.text.trim().toString();
        // String otpno = countryController.text.trim().toString();
        // print("sendnumber" + otpno);
        LoginPage.VARIFY = verificationId;
        // print("${widget.countryController.toString()}");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BlocProvider(
        //           create: (context) =>
        //               OtpCubit(repository: widget.repository),
        //           child: OptVarified(
        //               repository: widget.repository,
        //               verificationId: LoginPage.VARIFY,
        //               number: countryController.text),
        //         )));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('codeAutoRetrievalTimeout');
      },
    );
  }

  Widget buidResendOtp() {
    return MaterialButton(
      minWidth: 100.0,
      color: Componant.commnColor,
      onPressed: () {
        ResendOtp();
      },
      child: Text(
        "Resend Otp",
        style: TextStyle(
            color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  // void starTimerIndicator() {
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (seconds > 0) {
  //       setState(() {
  //         seconds--;
  //       });
  //     } else {
  //       setState(() {
  //         _timeShow = false;
  //       });
  //       timer.cancel();
  //     }
  //   });
  // }

  // addStringToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('stringValue', "abc");
  // }
  //
  // getStringValuesSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   String? stringValue = prefs.getString('stringValue');
  //   return stringValue;
  // }

  @override
  void initState() {
    starTimer();
    // TODO: implement initState
    otpVeryFied = context.read<OtpCubit>();
    // saveUserInfo();
    // intialGetDataSaved();
    // initialGetSaved();
    super.initState();
  }

  var otpVeryFied;
  static var loginresponse;

  void initialGetSaved() async {
    widget.sharedPreferences = await SharedPreferences.getInstance();

    // Read the data, decode it and store it in map structure
    Map<String, dynamic> jsondatais =
        jsonDecode(widget.sharedPreferences!.getString('userdata')!);
    loginresponse = LoginResponse.fromJson(jsondatais);
    if (jsondatais.isNotEmpty) {
      print(loginresponse.name);
      print(loginresponse.email);
    }
  }

  late LoginResponse user1;

  void storeUserData() {
    //store the user entered data in user object

    // encode / convert object into json string
    String user = jsonEncode(user1);

    print("user =============> ${user.toString()}");
    //save the data into sharedPreferences using key-value pairs
    widget.sharedPreferences?.setString('userdata', user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otp Verification"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Varification Code",
            style: TextStyle(color: Colors.grey, fontSize: 30.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "sent to your ",
                style: TextStyle(color: Colors.grey, fontSize: 20.0),
              ),
              Text(
                widget.number ?? "nothing",
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Pinput(
              onChanged: (value) {
                code = value;
              },
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                textStyle: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600),
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: BlocConsumer<OtpCubit, OtpState>(
              listener: (context, state) {
                if (state is OtpLoadingState) {
                  CircularProgressIndicator();
                } else if (state is OtpSuccessState) {
                  if (state.response.error == false) {
                    // user = state.response;
                    user1 = state.response;
                    print("successsssss");
                  } else {
                    print("not valid ====> ");
                  }
                }
                // if (state is OtpSuccessState) {
                //   print("respose state ====> ${state.response}");
                //
                //   // if (state.response.error == false) {
                //   // otpVeryFied.sharedname = state.response.name;
                //   // storeData();
                //   // }
                //   // else {
                //   //   print("not valid ====> ");
                //   // }

                else if (state is OtpErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return Visibility(
                  visible: !_isShow,
                  replacement: CircularProgressIndicator(
                    color: Componant.commnColor,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      // setState(() {
                      //   visible = true;
                      // });
                      if (_isShow = !_isShow) {
                        setState(() {
                          Future.delayed(Duration(milliseconds: 1000), () {
                            setState(() {
                              _isShow = !_isShow;
                            });
                          });
                        });
                      } else {
                        setState(() {
                          Future.delayed(Duration(seconds: 3), () {
                            setState(() {
                              _isShow == _isShow;
                            });
                          });
                        });
                      }
                      varifyOtp();

                      // getUserInfo();
                      // print(user);
                      // otpVeryFied.otpVerify(widget.number, 'school');
                      // storeData();
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
            ),
          ),
          Visibility(
            visible: _timeShow,
            replacement: Container(),
            child: Padding(
                padding: const EdgeInsets.only(top: 30.0), child: buildTimer()),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "Didn't Recevie the OTP ?",
              style: TextStyle(color: Colors.black54, fontSize: 17.0),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Visibility(
              replacement: Container(),
              visible: !_timeShow,
              child: buidResendOtp(),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       storeData();
          //     },
          //     child: Text("data")),
          // Text(user?.name ?? 'Test'),
        ],
      ),
    );
  }

  // LoginPage? loginPage;

  void varifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: LoginPage.VARIFY, smsCode: code);
      await auth.signInWithCredential(credential);
      // ConfirmationResult confirmationResult =
      // if (s.credential != null) {
      //   print(s);
      // } else {
      //   print("else");
      // }

      print(widget.number);
      // print("user ============>$user");
      otpVeryFied.otpVerify(widget.number, 'school');
      storeUserData();
      initialGetSaved();
      // starTimerIndicator();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) =>
                        NoverifyCubit(repository: widget.repository),
                    child: HomePage(
                      sharedUser: loginresponse,
                      repository: widget.repository,
                    ),
                  )));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("something wrong")));
    }
  }

// void intialGetDataSaved() async {
//   sharedPreferences = await SharedPreferences.getInstance();
//   Map<String, dynamic> json =
//       jsonDecode(sharedPreferences!.getString(KEYNAME).toString());
//   user = LoginResponse.fromJson(json);
//   setState(() {});
// }
//
// void storeData() {
//   // String json = jsonDecode(user as String);
//   // user = jsonEncode(Post.fromJson(json as Map<String, dynamic>)) as Post?;
//   // user = JsonEncoder(user as Object? Function(dynamic object)?) as Post?;
//   sharedPreferences?.setString(KEYNAME, user.toString());
//   print("===========> user reposne $user");
// }

// Future<void> saveUserInfo() async {
//   final LoginResponse loginResponse = LoginResponse.fromJson(json);
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool result = await prefs.setString('user', jsonEncode(loginResponse));
//   print("loginrepose shredprefrence in getuserInfo Method  #7525");
//   print(result);
// }
//
// LoginResponse? loginResponse;
//
// Future<LoginResponse?> getUserInfo() async {
//   print("getUserInfo presss #123");
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   Map<String, dynamic> userMap = {};
//   final String? userStr = prefs.getString('user');
//   if (userStr != null) {
//     userMap = jsonDecode(userStr) as Map<String, dynamic>;
//   }
//   loginResponse = LoginResponse.fromJson(userMap);
//   print("5252${loginResponse.toString()}");
//   return loginResponse;
// // }
//   save(String key, value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, json.encode(value));
//   }
//
//   read(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return json.decode(prefs.getString(key!));
//   }
}
