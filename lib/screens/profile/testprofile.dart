import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skola/component/color.dart';
import 'package:skola/data/Login/noverify_cubit.dart';
import 'package:skola/data/teacher_leave/teacher_leaves_cubit.dart';
import 'package:skola/data/teacher_profile/teacher_profile_cubit.dart';
import 'package:skola/network/entity/teacher_profile_model/TeacherProfileModel.dart';
import 'package:skola/screens/login_page/login.dart';
import 'package:skola/screens/login_page/otp.dart';
import '../../component/constant.dart';
import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/repository/Repository.dart';

class UserProfile extends StatefulWidget {
  late LoginResponse sharedUser;
  late Repository repository;

  UserProfile({Key? key, required this.repository, required this.sharedUser})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var teacherProfile;
  late final TeacherProfileModel teacherDetail;

  OptVarified? otpVarified;

  @override
  void initState() {
    context
        .read<TeacherProfileCubit>()
        .teacherDetail(widget.sharedUser.userId.toString());
  }

  Future buildLogOutBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              actions: [
                Center(
                  child: Container(
                    child: Center(
                        child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white60,
                    )),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Componant.commnColor,
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Text(
                    "Logout !",
                    style: TextStyle(
                      color: Componant.commnColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Center(
                    child: Text('Are you sure You want to logout ? '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () async {
                          SharedPreferences userData =
                              await SharedPreferences.getInstance();
                          await userData.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => NoverifyCubit(
                                      repository: widget.repository),
                                  child: LoginPage(
                                    repository: widget.repository,
                                  ),
                                ),
                              ));
                        },
                        minWidth: 130.0,
                        height: 48.0,
                        color: Componant.commnColor,
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0)),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        minWidth: 130.0,
                        height: 48.0,
                        color: Componant.commnColor,
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0)),
                      )
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: 840,
            width: 500,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  child: Container(
                    width: 500,
                    height: 220,
                    decoration: BoxDecoration(color: Componant.commnColor),
                  ),
                ),
                Positioned(
                  top: 1,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white60,
                      )),
                ),
                Positioned(
                  top: 1,
                  right: 10,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: IconButton(
                        onPressed: () {
                          print("press");
                          buildLogOutBox();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Componant.commnColor,
                        )),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(color: Colors.white)),
                    // margin: new EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${widget.sharedUser.photo}',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 145,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "${widget.sharedUser.name?.toUpperCase()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 180.0),
                  child: Positioned(
                    bottom: -10,
                    child: Container(
                      height: double.maxFinite,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 190.0,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0, color: Colors.black12),
                                  ], borderRadius: BorderRadius.circular(10.0)),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: BlocConsumer<TeacherProfileCubit,
                                        TeacherProfileState>(
                                      listener: (context, state) {
                                        if (state
                                            is TeacherProfileLoadingState) {
                                          print("Loading...");
                                        } else if (state
                                            is TeacherProfileSuccessState) {
                                          // TeacherProfileCubit cubit = TeacherProfileCubit.get(context);

                                          print(
                                              "TeacherProfileResponse=========>${state.response}");
                                        } else if (state
                                            is TeacherProfileErrorState) {
                                          print(
                                              "error" + state.error.toString());
                                        }
                                      },
                                      builder: (context, state) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Personal Information",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 18.0),
                                                    ),
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors.black38,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Contact",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 50.0,
                                                  ),
                                                  Text(
                                                    "Email",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      child: Flexible(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${widget.sharedUser.contactNumber1}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Date Of Birth",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 21.0,
                                                    ),
                                                    Text(
                                                      "Gender",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      child: Flexible(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Address",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 50.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // Container(
                                //   width: double.maxFinite,
                                //   decoration: BoxDecoration(boxShadow: [
                                //     BoxShadow(
                                //         blurRadius: 5.0, color: Colors.black12),
                                //   ], borderRadius: BorderRadius.circular(10.0)),
                                //   child: Card(
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(
                                //           10.0), //<-- SEE HERE
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Column(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: <Widget>[
                                //                 Text(
                                //                   "Bank Information",
                                //                   style: TextStyle(
                                //                       fontWeight:
                                //                           FontWeight.bold,
                                //                       color: Colors.black,
                                //                       fontSize: 18.0),
                                //                 ),
                                //                 Icon(
                                //                   Icons.house,
                                //                   color: Colors.black38,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           Row(
                                //             children: [
                                //               Text(
                                //                 "Bank Name",
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     fontSize: 15,
                                //                     color: Colors.black),
                                //               ),
                                //               SizedBox(
                                //                 width: 80.0,
                                //               ),
                                //               Text(
                                //                 "Account Number",
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     fontSize: 15,
                                //                     color: Colors.black),
                                //               ),
                                //             ],
                                //           ),
                                //           Padding(
                                //             padding:
                                //                 const EdgeInsets.only(top: 8.0),
                                //             child: Row(
                                //               children: [
                                //                 Container(
                                //                   width: 50,
                                //                   child: Flexible(
                                //                     child: Text(
                                //                       overflow:
                                //                           TextOverflow.ellipsis,
                                //                       "00",
                                //                       style: TextStyle(
                                //                           color:
                                //                               Colors.black45),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 SizedBox(
                                //                   width: 90,
                                //                 ),
                                //                 Container(
                                //                   width: 50,
                                //                   child: Flexible(
                                //                     child: Text(
                                //                       overflow:
                                //                           TextOverflow.ellipsis,
                                //                       "00",
                                //                       style: TextStyle(
                                //                           color:
                                //                               Colors.black45),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding:
                                //                 const EdgeInsets.only(top: 8.0),
                                //             child: Row(
                                //               children: [
                                //                 Text(
                                //                   "Branch Name",
                                //                   style: TextStyle(
                                //                       fontWeight:
                                //                           FontWeight.bold,
                                //                       fontSize: 15,
                                //                       color: Colors.black),
                                //                 ),
                                //                 SizedBox(
                                //                   width: 100.0,
                                //                 ),
                                //                 Text(
                                //                   "Branch Code",
                                //                   style: TextStyle(
                                //                       fontWeight:
                                //                           FontWeight.bold,
                                //                       fontSize: 15,
                                //                       color: Colors.black),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding:
                                //                 const EdgeInsets.only(top: 8.0),
                                //             child: Row(
                                //               children: [
                                //                 Container(
                                //                   width: 50,
                                //                   child: Flexible(
                                //                     child: Text(
                                //                       overflow:
                                //                           TextOverflow.ellipsis,
                                //                       "00",
                                //                       style: TextStyle(
                                //                           color:
                                //                               Colors.black45),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0, color: Colors.black12),
                                  ], borderRadius: BorderRadius.circular(10.0)),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), //<-- SEE HERE
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "School Information",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18.0),
                                                ),
                                                Icon(
                                                  Icons.house,
                                                  color: Colors.black38,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Bank Name",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Branch Name",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Account Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Branch Code",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0, color: Colors.black12),
                                  ], borderRadius: BorderRadius.circular(10.0)),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), //<-- SEE HERE
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Bank Information",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18.0),
                                                ),
                                                Icon(
                                                  Icons.house,
                                                  color: Colors.black38,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Joining Date",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "GPF Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Seniority Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Employment Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "CPF Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Mandail Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0, color: Colors.black12),
                                  ], borderRadius: BorderRadius.circular(10.0)),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), //<-- SEE HERE
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Other Information",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18.0),
                                                ),
                                                Icon(
                                                  Icons.house,
                                                  color: Colors.black38,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Pan-Card Number ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "Driving Licence",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Voter-Card Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
