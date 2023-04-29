import 'package:flutter/material.dart';
import 'package:skola/component/color.dart';

class StudentLeaveDetail extends StatefulWidget {
  static String route = 'lobby';
  String? leaveType;
  String? duration;
  String? total;
  String? reason;
  String? leaveStatus;
  String? notes;

  StudentLeaveDetail(
      {Key? key,
      required this.leaveType,
      required this.duration,
      required this.total,
      required this.reason,
      required this.leaveStatus,
      required this.notes})
      : super(key: key);

  @override
  State<StudentLeaveDetail> createState() => _StudentLeaveDetailState();
}

class _StudentLeaveDetailState extends State<StudentLeaveDetail> {
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
                              "${widget.leaveStatus == "Pending" ? "Awaiting" : widget.leaveStatus}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: widget.leaveStatus == "Pending"
                                      ? Colors.amber[600]
                                      : Componant.commnColor),
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
          ],
        ),
      ),
    );
  }
}
