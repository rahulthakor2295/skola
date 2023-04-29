import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skola/component/color.dart';
import 'package:skola/component/constant.dart';
import 'package:skola/data/student_leave/student_leave_cubit.dart';
import 'package:skola/data/teacher_leave/teacher_leaves_cubit.dart';
import 'package:skola/network/repository/Repository.dart';

import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../cardTap/student_leaves.dart';

class HomeCard extends StatelessWidget {
  late Repository repository;
  LoginResponse sharedUser;
  static String route = 'lobby';

  HomeCard({Key? key, required this.repository, required this.sharedUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(blurRadius: 5.0, color: Colors.black26),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Other",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      InkWell(
                        child: OtherCard(
                            icon: Icons.school_sharp, text: "Leave's"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      StudentLeaveCubit(repository: repository),
                                  child: StudenLeavesScreen(
                                    repository: repository,
                                    sharedUser: sharedUser,
                                  ),
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      InkWell(
                          child: OtherCard(
                              icon: Icons.school_sharp, text: "My Attendance"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      OtherCard(icon: Icons.school_sharp, text: "Chat")
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      OtherCard(
                          icon: Icons.school_sharp, text: "Result Permission")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OtherCard extends StatelessWidget {
  IconData icon;
  String text;

  OtherCard({required this.icon, required this.text});

  otherCard(icon, text) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Componant.commnColor,
                  ),
                  Container(
                    width: 65.0,
                    child: Text(text, style: textStyle),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Componant.commnColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0))),
              height: double.infinity,
              width: 13.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return otherCard(icon, text);
  }
}
