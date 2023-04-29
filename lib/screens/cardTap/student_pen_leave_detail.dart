import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skola/component/color.dart';
import 'package:skola/data/update_leave_status/update_leave_status_cubit.dart';
import 'package:skola/network/entity/update_leave_status/UpdateLeaveStatusModel.dart';
import 'package:skola/screens/cardTap/student_leaves.dart';

import '../../data/student_leave/student_leave_cubit.dart';
import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/repository/Repository.dart';

class StudentPenLeaveDetail extends StatefulWidget {
  static String route = 'lobby';
  Repository repository;
  LoginResponse sharedUser;
  String? leaveType;
  String? duration;
  String? total;
  String? reason;
  String? leaveStatus;
  String? notes;

  String? userId;
  String leaveId;
  String? leaveRemark;
  String? updateBy;
  String? roleId;

  StudentPenLeaveDetail({
    Key? key,
    required this.leaveType,
    required this.duration,
    required this.total,
    required this.reason,
    required this.leaveStatus,
    required this.notes,
    required this.userId,
    required this.leaveRemark,
    required this.updateBy,
    required this.roleId,
    required this.repository,
    required this.sharedUser,
    required this.leaveId,
  }) : super(key: key);

  @override
  State<StudentPenLeaveDetail> createState() => _StudentPenLeaveDetailState();
}

class _StudentPenLeaveDetailState extends State<StudentPenLeaveDetail> {
  UpdateLeaveStatusModel? reponse;

  TextStyle valStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black87);
  TextStyle valHeadStyle = TextStyle(
    color: Colors.black38,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 3.0, color: Colors.black38)
                  ],
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 3.0, color: Colors.black38)
                    ],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Leave Type", style: valHeadStyle),
                            ),
                            Text("${widget.leaveType}", style: valStyle),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(
                                height: 2.0,
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Duration", style: valHeadStyle),
                            ),
                            Text("${widget.duration}", style: valStyle),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(
                                height: 2.0,
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Total", style: valHeadStyle),
                            ),
                            Text("${widget.total}", style: valStyle),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(
                                height: 2.0,
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Reason", style: valHeadStyle),
                            ),
                            Text("${widget.reason}", style: valStyle),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(
                                height: 2.0,
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Leave Status", style: valHeadStyle),
                            ),
                            Text(
                              "${widget.leaveStatus}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[600]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(
                                height: 2.0,
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Notes", style: valHeadStyle),
                            ),
                            Text("${widget.notes}", style: valStyle),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(
                                height: 2.0,
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  BlocConsumer<UpdateLeaveStatusCubit, UpdateLeaveStatusState>(
                    listener: (context, state) {
                      if (state is UpdateLeaveStatusLoadingState) {
                        print("Loading...");
                      } else if (state is UpdateLeaveStatusSuccessState) {
                        reponse = state.response;
                        Get.to(
                          BlocProvider(
                            create: (context) => StudentLeaveCubit(
                                repository: widget.repository),
                            child: StudenLeavesScreen(
                              repository: widget.repository,
                              sharedUser: widget.sharedUser,
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          print("UpdateLeaveStatusResponse ===> ${reponse}");
                          context
                              .read<UpdateLeaveStatusCubit>()
                              .updateLeaveStatus(
                                  widget.userId.toString(),
                                  widget.leaveId.toString(),
                                  'Approved',
                                  widget.leaveRemark.toString(),
                                  widget.sharedUser.userId.toString(),
                                  widget.sharedUser.role.toString());
                        },
                        child: Container(
                          height: 60.0,
                          width: 150.0,
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Center(
                              child: Text(
                                "Leave Approve",
                                style: TextStyle(
                                    color: Componant.commnColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocConsumer<UpdateLeaveStatusCubit, UpdateLeaveStatusState>(
                    listener: (context, state) {
                      if (state is UpdateLeaveStatusLoadingState) {
                        CircularProgressIndicator();
                      } else if (state is UpdateLeaveStatusSuccessState) {
                        reponse = state.response;
                        Get.to(
                          BlocProvider(
                            create: (context) => StudentLeaveCubit(
                                repository: widget.repository),
                            child: StudenLeavesScreen(
                              repository: widget.repository,
                              sharedUser: widget.sharedUser,
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          print("UpdateLeaveStatusResponse ===> ${reponse}");
                          context
                              .read<UpdateLeaveStatusCubit>()
                              .updateLeaveStatus(
                                  widget.userId.toString(),
                                  widget.leaveId.toString(),
                                  'Declined',
                                  widget.leaveRemark.toString(),
                                  widget.sharedUser.userId.toString(),
                                  widget.sharedUser.role.toString());
                        },
                        child: Container(
                          height: 60.0,
                          width: 150.0,
                          child: Card(
                            child: Center(
                              child: Text(
                                "Leave Decline",
                                style: TextStyle(
                                    color: Colors.pink[500],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
