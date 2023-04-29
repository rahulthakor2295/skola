import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skola/data/add_leave/add_leave_cubit.dart';
import 'package:skola/data/teacher_leave/teacher_leaves_cubit.dart';
import 'package:skola/network/entity/teacher_leave_model/Data.dart';
import 'package:skola/network/repository/Repository.dart';
import 'leave_detail.dart';
import 'student_leaves.dart';
import '../../component/constant.dart';
import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/entity/teacher_leave_model/LeaveRequestResponse.dart';
import 'add_leaves.dart';
import 'package:get/get.dart';

class MyLeaves extends StatefulWidget {
  Repository repository;
  LoginResponse sharedUser;
  static String route = 'lobby';

  MyLeaves({Key? key, required this.repository, required this.sharedUser})
      : super(key: key);

  @override
  State<MyLeaves> createState() => _MyLeavesState();
}

class _MyLeavesState extends State<MyLeaves> {
  String dropdownvalue = 'pending';
  var dropdownlist = ["pending", "approved", "rejected", 'new'];
  LeaveRequestResponse? respone;
  var myLeave;

  @override
  void initState() {
    super.initState();
    int roleId = (int.parse(widget.sharedUser.role.toString()) - 1);

    context.read<TeacherLeaveCubit>().getLeavesCubit(
        widget.sharedUser.schoolId.toString(),
        widget.sharedUser.yearId.toString(),
        dropdownvalue,
        roleId.toString(),
        widget.sharedUser.userId.toString());
  }

  List<Data>? repoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Leave's"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3.0, color: Colors.black38)
                                ],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.computer),
                                Text(
                                  "Add Leave",
                                  style: textStyle,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => AddLeaveCubit(
                                              repository: widget.repository),
                                          child: AddLeave(
                                            repository: widget.repository,
                                            sharedUser: widget.sharedUser,
                                          ),
                                        )));
                          },
                        ),
                        Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3.0, color: Colors.black38)
                                ],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropdownvalue,
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 28,
                                    color: Colors.black38,
                                  ),
                                ),
                                items: dropdownlist.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        items,
                                        style: textStyle,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                    newValue = newValue ?? "pending";
                                  });

                                  if (repoList!.length < 1) {
                                    print(
                                        "repolist length =>>${repoList!.length}");
                                  } else {
                                    repoList?.clear();
                                  }
                                  context
                                      .read<TeacherLeaveCubit>()
                                      .getLeavesCubit(
                                          widget.sharedUser.schoolId.toString(),
                                          "6",
                                          newValue!,
                                          "2",
                                          "111");
                                },
                              ),
                            )
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: <Widget>[
                            //     Icon(Icons.computer),
                            //     Text(
                            //       "My Leave",
                            //       style: textStyle,
                            //     ),
                            //   ],
                            // ),
                            ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      BlocConsumer<TeacherLeaveCubit, TeacherLeaveState>(
                          listener: (context, state) {
                        if (state is TeacherLeaveLoadingState) {
                          print("Loading....");
                        } else if (state is TeacherLeaveSuccessState) {
                          final List<Data>? teacherLeaveResponse =
                              state.response.data;
                          respone = state.response;
                          // final repoImage = teacherLeaveResponse!.data;
                          // responseList = repoImage!.cast<String>();
                          // print(
                          // "-----------------------------------------${repoImage!.length}");

                          // for (var i = 0; i < teacherLeaveResponse!.length; i++) {
                          //   print("----------------------------------$i");
                          //   repoList.add(Data(
                          //       days: teacherLeaveResponse[i].days.toString()));
                          // }
                          // String leaveIdString = repoList[0].days.toString();
                          // print("#1188 leaveIdString ====> ${leaveIdString}");

                          setState(() {
                            repoList = teacherLeaveResponse ?? List.empty();
                          });
                        }
                      }, builder: (context, state) {
                        // String leaveIdString = repoList[0].days.toString();

                        print("reponseList ==g==>${repoList}");
                        switch (dropdownvalue) {
                          case "pending":
                            if (respone?.error == true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/Images/icons/Mediamodifier-Design.svg',
                                          height: 200,
                                          width: 200,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          "No Data Available",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width: 170.0,
                                          child: Center(
                                            child: Text(
                                              "There is no data to show you right now",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black38,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: 600,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: repoList?.length,
                                    itemBuilder: (context, index) {
                                      String startDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .startDate
                                                  .toString()));
                                      String endDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .endDate
                                                  .toString()));

                                      return Container(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 15.0,
                                                bottom: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${repoList![index].leaveType}  Application",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25.0),
                                                      child: Center(
                                                        child: Container(
                                                          height: 25,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .amber[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          child: Center(
                                                            child: Text(
                                                              "Awaiting",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .amber[
                                                                      600],
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0,
                                                          bottom: 5.0),
                                                  child: Text(
                                                    "${startDateFormatted}  ${endDateFormatted == startDateFormatted ? '' : '-${endDateFormatted}'}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "${repoList![index].leaveType}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.amber[500],
                                                          fontSize: 15.0),
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Get.to(LeaveDetail(
                                                            leaveType:
                                                                '${repoList![index].leaveType}',
                                                            duration:
                                                                '${startDateFormatted} ${endDateFormatted == startDateFormatted ? '' : endDateFormatted}',
                                                            total:
                                                                '${repoList![index].days}',
                                                            reason:
                                                                '${repoList![index].leaveReason}',
                                                            leaveStatus:
                                                                '${repoList![index].leaveStatus}',
                                                            notes:
                                                                '${repoList![index].leaveNote}',
                                                          ));
                                                          print(
                                                              "preswww button");
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            size: 20,
                                                            color:
                                                                Colors.black38),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      );
                                    }),
                              );
                            }

                          case "approved":
                            if (respone?.error == true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/Images/icons/Mediamodifier-Design.svg',
                                          height: 200,
                                          width: 200,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          "No Data Available",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width: 170.0,
                                          child: Center(
                                            child: Text(
                                              "There is no data to show you right now",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black38,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: 600.0,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: repoList?.length,
                                    itemBuilder: (context, index) {
                                      String startDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .startDate
                                                  .toString()));
                                      String endDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .endDate
                                                  .toString()));

                                      return Container(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 15.0,
                                                bottom: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${repoList![index].leaveType}  Application",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25.0),
                                                      child: Center(
                                                        child: Container(
                                                          height: 25,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .green[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          child: Center(
                                                            child: Text(
                                                              "Approved",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .green[
                                                                      600],
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0,
                                                          bottom: 5.0),
                                                  child: Text(
                                                    "${startDateFormatted} - ${endDateFormatted}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "${repoList![index].leaveType}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[500],
                                                          fontSize: 15.0),
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Get.to(LeaveDetail(
                                                            leaveType:
                                                                '${repoList![index].leaveType}',
                                                            duration:
                                                                '${startDateFormatted}- ${endDateFormatted}',
                                                            total: '8',
                                                            reason:
                                                                '${repoList![index].leaveReason}',
                                                            leaveStatus:
                                                                '${repoList![index].leaveStatus}',
                                                            notes:
                                                                '${repoList![index].leaveNote}',
                                                          ));
                                                          Get.to(LeaveDetail(
                                                            leaveType:
                                                                '${repoList![index].leaveType}',
                                                            duration:
                                                                '${startDateFormatted}- ${endDateFormatted}',
                                                            total: '8',
                                                            reason:
                                                                '${repoList![index].leaveReason}',
                                                            leaveStatus:
                                                                '${repoList![index].leaveStatus}',
                                                            notes:
                                                                '${repoList![index].leaveNote}',
                                                          ));
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            size: 20,
                                                            color:
                                                                Colors.black38),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      );
                                    }),
                              );
                            }

                          case "rejected":
                            if (respone?.error == true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/Images/icons/Mediamodifier-Design.svg',
                                          height: 200,
                                          width: 200,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          "No Data Available",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width: 170.0,
                                          child: Center(
                                            child: Text(
                                              "There is no data to show you right now",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black38,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: 600.0,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: repoList?.length,
                                    itemBuilder: (context, index) {
                                      String startDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .startDate
                                                  .toString()));
                                      String endDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .endDate
                                                  .toString()));

                                      return Container(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 15.0,
                                                bottom: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${repoList![index].leaveType}  Application",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25.0),
                                                      child: Center(
                                                        child: Container(
                                                          height: 25,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .pink[500],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          child: Center(
                                                            child: Text(
                                                              "Declined",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0,
                                                          bottom: 5.0),
                                                  child: Text(
                                                    "${startDateFormatted} - ${endDateFormatted}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "${repoList![index].leaveType}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.pink[500],
                                                          fontSize: 15.0),
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Get.to(LeaveDetail(
                                                            leaveType:
                                                                '${repoList![index].leaveType}',
                                                            duration:
                                                                '${startDateFormatted}- ${endDateFormatted}',
                                                            total: '8',
                                                            reason:
                                                                '${repoList![index].leaveReason}',
                                                            leaveStatus:
                                                                '${repoList![index].leaveStatus}',
                                                            notes:
                                                                '${repoList![index].leaveNote}',
                                                          ));
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            size: 20,
                                                            color:
                                                                Colors.black38),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      );
                                    }),
                              );
                            }
                          case 'new':
                            return Container(
                              height: 1000,
                              child: ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.all(10.0),
                                        height: 100,
                                        width: 250,
                                        color: Colors.pink);
                                  }),
                            );
                          default:
                            if (respone?.error == true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/Images/icons/Mediamodifier-Design.svg',
                                          height: 200,
                                          width: 200,
                                          color: Colors.black54,
                                        ),
                                        Text(
                                          "No Data Available",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width: 170.0,
                                          child: Center(
                                            child: Text(
                                              "There is no data to show you right now",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black38,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: 600.0,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: repoList?.length,
                                    itemBuilder: (context, index) {
                                      String startDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .startDate
                                                  .toString()));
                                      String endDateFormatted =
                                          DateFormat('E, d, MMM yy').format(
                                              DateTime.parse(repoList![index]
                                                  .endDate
                                                  .toString()));

                                      return Container(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 15.0,
                                                bottom: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${repoList![index].leaveType}  Application",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25.0),
                                                      child: Center(
                                                        child: Container(
                                                          height: 25,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .amber[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          child: Center(
                                                            child: Text(
                                                              "Awaiting",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .amber[
                                                                      600],
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0,
                                                          bottom: 5.0),
                                                  child: Text(
                                                    "${startDateFormatted} - ${endDateFormatted}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "${repoList![index].leaveType}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.amber[500],
                                                          fontSize: 15.0),
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Get.to(LeaveDetail(
                                                            leaveType:
                                                                '${repoList![index].leaveType}',
                                                            duration:
                                                                '${startDateFormatted}- ${endDateFormatted}',
                                                            total: '8',
                                                            reason:
                                                                '${repoList![index].leaveReason}',
                                                            leaveStatus:
                                                                '${repoList![index].leaveStatus}',
                                                            notes:
                                                                '${repoList![index].leaveNote}',
                                                          ));
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            size: 20,
                                                            color:
                                                                Colors.black38),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      );
                                    }),
                              );
                            }
                        }
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
