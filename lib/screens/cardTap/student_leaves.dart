import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:skola/component/color.dart';
import 'package:skola/data/student_leave/student_leave_cubit.dart';
import 'package:skola/data/update_leave_status/update_leave_status_cubit.dart';
import 'package:skola/network/repository/Repository.dart';
import 'package:skola/screens/cardTap/my_leaves.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skola/screens/cardTap/student_leave_detail.dart';
import 'package:skola/screens/cardTap/student_pen_leave_detail.dart';
import '../../component/constant.dart';
import '../../data/teacher_leave/teacher_leaves_cubit.dart';
import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/entity/student_get_leave_model/Data.dart';
import '../../network/entity/student_get_leave_model/StudentGetLeaveModel.dart';

class StudenLeavesScreen extends StatefulWidget {
  Repository repository;
  LoginResponse sharedUser;
  static String route = 'lobby';

  StudenLeavesScreen(
      {Key? key, required this.repository, required this.sharedUser})
      : super(key: key);

  @override
  State<StudenLeavesScreen> createState() => _StudenLeavesScreenState();
}

class _StudenLeavesScreenState extends State<StudenLeavesScreen> {
  String dropdownvalue = 'pending';
  var dropdownlist = ["pending", "approved", "rejected"];
  var myLeave;
  StudentGetLeaveModel? studentGetLeaveResponse;
  List<Data> studentRepoList = [];

  @override
  void initState() {
    context.read<StudentLeaveCubit>().getStudentLeavesCubit(
        widget.sharedUser.schoolId.toString(),
        widget.sharedUser.yearId.toString(),
        dropdownvalue,
        widget.sharedUser.role.toString(),
        widget.sharedUser.userId.toString());
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Leave's"),
      ),
      body: SingleChildScrollView(
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
                              BoxShadow(blurRadius: 3.0, color: Colors.black38)
                            ],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.computer),
                            Text(
                              "My Leave",
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
                                      create: (context) => TeacherLeaveCubit(
                                          repository: widget.repository),
                                      child: MyLeaves(
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
                              BoxShadow(blurRadius: 3.0, color: Colors.black38)
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
                              if (studentRepoList.length < 1) {
                                print(
                                    "repolist length =>>${studentRepoList.length}");
                              } else {
                                studentRepoList.clear();
                              }
                              context
                                  .read<StudentLeaveCubit>()
                                  .getStudentLeavesCubit(
                                      widget.sharedUser.schoolId.toString(),
                                      widget.sharedUser.yearId.toString(),
                                      newValue!,
                                      widget.sharedUser.role.toString(),
                                      widget.sharedUser.userId.toString());
                            },
                          ),
                        )),
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
                  BlocConsumer<StudentLeaveCubit, StudentLeaveState>(
                    listener: (context, state) {
                      if (state is StudentLeaveLoadingState) {
                        print("Loading....");
                      } else if (state is StudentLeaveSuccessState) {
                        final List<Data>? studentLeaveResponse =
                            state.response.data;
                        print("Student reposne ===>${studentLeaveResponse}");
                        studentGetLeaveResponse = state.response;
                        setState(() {
                          studentRepoList =
                              studentLeaveResponse ?? List.empty();
                        });
                      }
                    },
                    builder: (context, state) {
                      switch (dropdownvalue) {
                        case 'pending':
                          if (studentGetLeaveResponse?.error == true) {
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
                              child: Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: studentRepoList.length,
                                  itemBuilder: (context, index) {
                                    String startDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .startDate
                                                    .toString()));
                                    String endDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .endDate
                                                    .toString()));
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 8.0, right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, right: 4.0),
                                              child: Positioned(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Componant.commnColor,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 8.0),
                                                  child: Text(
                                                    "${studentRepoList[index].userName}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: 50.0,
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0),
                                              child: Positioned(
                                                child: Container(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15.0,
                                                              top: 15.0,
                                                              bottom: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${studentRepoList[index].leaveType} Application",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25.0),
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.amber[
                                                                            100],
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Awaiting",
                                                                        style: TextStyle(
                                                                            color: Colors.amber[
                                                                                600],
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5.0,
                                                                    bottom:
                                                                        5.0),
                                                            child: Text(
                                                              "${startDateFormatted}  ${endDateFormatted == startDateFormatted ? '' : '-${endDateFormatted}'}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      22.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                "${studentRepoList[index].leaveReason}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .amber[
                                                                        500],
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Container(
                                                                height: 45,
                                                                width: 45,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black12,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.to(
                                                                      BlocProvider(
                                                                        create: (context) =>
                                                                            UpdateLeaveStatusCubit(repository: widget.repository),
                                                                        child:
                                                                            StudentPenLeaveDetail(
                                                                          leaveType:
                                                                              '${studentRepoList[index].leaveType}',
                                                                          duration:
                                                                              '${startDateFormatted} ${endDateFormatted == startDateFormatted ? '' : endDateFormatted}',
                                                                          total:
                                                                              '${studentRepoList[index].days}',
                                                                          reason:
                                                                              '${studentRepoList[index].leaveReason}',
                                                                          leaveStatus:
                                                                              '${studentRepoList[index].leaveStatus}',
                                                                          notes:
                                                                              '${studentRepoList[index].leaveNote}',
                                                                          repository:
                                                                              widget.repository,
                                                                          sharedUser:
                                                                              widget.sharedUser,
                                                                          leaveId:
                                                                              '${studentRepoList[index].leaveId}',
                                                                          userId:
                                                                              '${studentRepoList[index].userId}',
                                                                          leaveRemark:
                                                                              '${studentRepoList[index].leaveRemark}',
                                                                          updateBy:
                                                                              '${widget.sharedUser.userId}',
                                                                          roleId:
                                                                              '${widget.sharedUser.role}',
                                                                        ),
                                                                      ),
                                                                    );
                                                                    print(
                                                                        "preswww button");
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        case "approved":
                          if (studentGetLeaveResponse?.error == true) {
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
                              child: Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: studentRepoList.length,
                                  itemBuilder: (context, index) {
                                    String startDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .startDate
                                                    .toString()));
                                    String endDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .endDate
                                                    .toString()));
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 8.0, right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, right: 4.0),
                                              child: Positioned(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Componant.commnColor,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 8.0),
                                                  child: Text(
                                                    "${studentRepoList[index].userName}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: 50.0,
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0),
                                              child: Positioned(
                                                child: Container(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15.0,
                                                              top: 15.0,
                                                              bottom: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "${studentRepoList[index].leaveType} Application",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25.0),
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.green[
                                                                            100],
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Approved",
                                                                        style: TextStyle(
                                                                            color: Colors.green[
                                                                                600],
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5.0,
                                                                    bottom:
                                                                        5.0),
                                                            child: Text(
                                                              "${startDateFormatted}  ${endDateFormatted == startDateFormatted ? '' : '-${endDateFormatted}'}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      22.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                "${studentRepoList[index].leaveReason}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .green[
                                                                        500],
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Container(
                                                                height: 45,
                                                                width: 45,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black12,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.to(
                                                                        StudentLeaveDetail(
                                                                      leaveType:
                                                                          '${studentRepoList[index].leaveType}',
                                                                      duration:
                                                                          '${startDateFormatted} ${endDateFormatted == startDateFormatted ? '' : endDateFormatted}',
                                                                      total:
                                                                          '${studentRepoList[index].days}',
                                                                      reason:
                                                                          '${studentRepoList[index].leaveReason}',
                                                                      leaveStatus:
                                                                          '${studentRepoList[index].leaveStatus}',
                                                                      notes:
                                                                          '${studentRepoList[index].leaveNote}',
                                                                    ));
                                                                    print(
                                                                        "preswww button");
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        case "rejected":
                          if (studentGetLeaveResponse?.error == true) {
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
                              child: Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: studentRepoList.length,
                                  itemBuilder: (context, index) {
                                    String startDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .startDate
                                                    .toString()));
                                    String endDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .endDate
                                                    .toString()));
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 8.0, right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, right: 4.0),
                                              child: Positioned(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Componant.commnColor,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 8.0),
                                                  child: Text(
                                                    "${studentRepoList[index].userName}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: 50.0,
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0),
                                              child: Positioned(
                                                child: Container(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15.0,
                                                              top: 15.0,
                                                              bottom: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "${studentRepoList[index].leaveType} Application",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25.0),
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.pink[
                                                                            100],
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Declined",
                                                                        style: TextStyle(
                                                                            color: Colors.pink[
                                                                                600],
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5.0,
                                                                    bottom:
                                                                        5.0),
                                                            child: Text(
                                                              "${startDateFormatted}  ${endDateFormatted == startDateFormatted ? '' : '-${endDateFormatted}'}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      22.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                "${studentRepoList[index].leaveReason}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .pink[
                                                                        500],
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Container(
                                                                height: 45,
                                                                width: 45,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black12,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.to(
                                                                        StudentLeaveDetail(
                                                                      leaveType:
                                                                          '${studentRepoList[index].leaveType}',
                                                                      duration:
                                                                          '${startDateFormatted} ${endDateFormatted == startDateFormatted ? '' : endDateFormatted}',
                                                                      total:
                                                                          '${studentRepoList[index].days}',
                                                                      reason:
                                                                          '${studentRepoList[index].leaveReason}',
                                                                      leaveStatus:
                                                                          '${studentRepoList[index].leaveStatus}',
                                                                      notes:
                                                                          '${studentRepoList[index].leaveNote}',
                                                                    ));
                                                                    print(
                                                                        "preswww button");
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        default:
                          if (studentGetLeaveResponse?.error == true) {
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
                              child: Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: studentRepoList.length,
                                  itemBuilder: (context, index) {
                                    String startDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .startDate
                                                    .toString()));
                                    String endDateFormatted =
                                        DateFormat('E, d, MMM yy').format(
                                            DateTime.parse(
                                                studentRepoList[index]
                                                    .endDate
                                                    .toString()));
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 8.0, right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, right: 4.0),
                                              child: Positioned(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Componant.commnColor,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 8.0),
                                                  child: Text(
                                                    "${studentRepoList[index].userName}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: 50.0,
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0),
                                              child: Positioned(
                                                child: Container(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15.0,
                                                              top: 15.0,
                                                              bottom: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "${studentRepoList[index].leaveType} Application",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25.0),
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    height: 25,
                                                                    width: 80,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.amber[
                                                                            100],
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Awaiting",
                                                                        style: TextStyle(
                                                                            color: Colors.amber[
                                                                                600],
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5.0,
                                                                    bottom:
                                                                        5.0),
                                                            child: Text(
                                                              "${startDateFormatted}  ${endDateFormatted == startDateFormatted ? '' : '-${endDateFormatted}'}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      22.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                "${studentRepoList[index].leaveReason}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .pink[
                                                                        500],
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Container(
                                                                height: 45,
                                                                width: 45,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black12,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.to(
                                                                        BlocProvider(
                                                                      create: (context) =>
                                                                          UpdateLeaveStatusCubit(
                                                                              repository: widget.repository),
                                                                      child:
                                                                          StudentPenLeaveDetail(
                                                                        leaveType:
                                                                            '${studentRepoList[index].leaveType}',
                                                                        duration:
                                                                            '${startDateFormatted} ${endDateFormatted == startDateFormatted ? '' : endDateFormatted}',
                                                                        total:
                                                                            '${studentRepoList[index].days}',
                                                                        reason:
                                                                            '${studentRepoList[index].leaveReason}',
                                                                        leaveStatus:
                                                                            '${studentRepoList[index].leaveStatus}',
                                                                        notes:
                                                                            '${studentRepoList[index].leaveNote}',
                                                                        repository:
                                                                            widget.repository,
                                                                        sharedUser:
                                                                            widget.sharedUser,
                                                                        leaveId:
                                                                            '${studentRepoList[index].leaveId}',
                                                                        userId:
                                                                            '${studentRepoList[index].userId}',
                                                                        leaveRemark:
                                                                            '${studentRepoList[index].leaveRemark}',
                                                                        updateBy:
                                                                            '${widget.sharedUser.userId}',
                                                                        roleId:
                                                                            '${widget.sharedUser.role}',
                                                                      ),
                                                                    ));
                                                                    print(
                                                                        "preswww button");
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
