import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skola/component/color.dart';
import 'package:skola/data/add_leave/add_leave_cubit.dart';
import 'package:skola/data/teacher_leave/teacher_leaves_cubit.dart';
import 'package:skola/network/repository/Repository.dart';
import 'package:skola/screens/cardTap/my_leaves.dart';

import '../../component/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skola/component/constant.dart';
import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/entity/teacher_leave_model/LeaveRequestResponse.dart';

enum day { FullDay, HalfDay }

class AddLeave extends StatefulWidget {
  late LoginResponse sharedUser;
  late Repository repository;
  static String route = 'lobby';

  AddLeave({Key? key, required this.repository, required this.sharedUser})
      : super(key: key);

  @override
  State<AddLeave> createState() => _AddLeaveState();
}

class _AddLeaveState extends State<AddLeave> {
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (leaveResionValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Select LeaveResion Type')),
        );
      } else if (leaveTypeValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Select LeaveType')),
        );
      } else if (startDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Select StartDate')),
        );
      } else if (endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Select EndDate')),
        );
      } else if (dt1!.isAfter(dt2!)) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Select Valid Date')));
      } else {
        int roleId = (int.parse(widget.sharedUser.role.toString()) - 1);
        print("RooooooolllllllllIIIIIIdddddddd${roleId.toString()}");
        addLeaves.addLeaves(
            widget.sharedUser.userId,
            widget.sharedUser.schoolId,
            widget.sharedUser.yearId,
            startDate,
            endDate,
            leaveTypeValue,
            leaveNoteController.text.trim(),
            leaveResionValue,
            widget.sharedUser.section,
            (roleId.toInt() - 1).toString(),
            getDay);
        starTimer();
        setState(() {
          indicator = true;
        });
      }
    } else {
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
    }
  }

  static const maxSeconds = 2;
  int seconds = maxSeconds;
  Timer? timer;
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          TeacherLeaveCubit(repository: widget.repository),
                      child: MyLeaves(
                        repository: widget.repository,
                        sharedUser: widget.sharedUser,
                      ),
                    )));
      }
    });
  }

  // Widget buuidtime() {
  //   return Center(
  //     child: CircularProgressIndicator(
  //       color: Componant.commnColor,
  //     ),
  //   );
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? leaveTypeValue;

  var leaveType = [
    "Annual Leave",
    "Casual Leave",
    "Special Leave",
    "Short Leave",
    "Other"
  ];
  String? leaveResionValue;

  var leaveResion = [
    "Vacation",
    "Sick-Self",
    "Sick-Family",
    "Doctor Appointment",
    "Leave of Absence",
    "Other"
  ];
  String getDay = "";
  TextEditingController leaveNoteController = TextEditingController();
  var kInactiveColor = Color(0xFFFF5FF);
  var kActivatecardColor = Componant.commnColor;
  var kTextInactiveColor = Colors.white;
  var kTextActivatecardColor = Componant.commnColor;

  day? SelectedDay = day.FullDay;
  String FullDay = day.FullDay.toString();
  String HalfDay = day.HalfDay.toString();
  String? startDate;
  String? endDate;
  var addLeaves;
  DateTime? dt1;
  DateTime? dt2;

  @override
  void initState() {
    // addLeaves = context.read<TeacherLeaveCubit>();
    // addLeaves.getLeavesCubit(widget.sharedUser.schoolId,
    //     widget.sharedUser.yearId, widget.sharedUser.);
    // TODO: implement initState
    addLeaves = context.read<AddLeaveCubit>();
    startDate = "Start Date";
    endDate = "End Date";
    super.initState();
  }

  bool _enabled = true;

  void _onTap() async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Componant.commnColor,
                // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Componant.commnColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        //get today's date
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(
          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(
          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      print(
          formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need

      setState(() {
        endDate = formattedDate;
        dt2 = DateTime.parse(
            formattedDate); //set foratted date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  void _offTap() {
    setState(() => _enabled = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Request Leave"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 3.0, color: Colors.black38)
                    ],
                    borderRadius: BorderRadius.circular(10.0)),
                // child: BlocBuilder<TeacherLeaveCubit, TeacherLeaveState>(
                //   builder: (context, state) {
                //     if (state is TeacherLeaveLoadingState) {
                //       Text("loading");
                //     } else if (state is TeacherLeaveSuccessState) {
                //       final dropReponse = state.response.data;
                //       print(
                //           "======================>${dropReponse![0].leaveType}");
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: leaveTypeValue,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 28,
                        color: Colors.black38,
                      ),
                    ),
                    items: leaveType.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            items,
                            style: textStyle,
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Select Leave Type ",
                        style: textStyle,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        leaveTypeValue = newValue!;
                      });
                    },
                  ),
                ), //     }
                //     return Text("");
                //   },
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        child: Container(
                          height: 50,
                          width: 150,
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
                              Icon(Icons.calendar_today_outlined, size: 20),
                              Text(
                                "${startDate != null ? startDate : "Start Data"}",
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Componant.commnColor,
                                      // <-- SEE HERE
                                      onPrimary: Colors.white, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Componant
                                            .commnColor, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              context: context,
                              initialDate: DateTime.now(),

                              //get today's date
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 0)),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              startDate = formattedDate; //
                              dt1 = DateTime.parse(
                                  formattedDate); // set foratted date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(blurRadius: 3.0, color: Colors.black38)
                            ],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                            ),
                            Text(
                              "${endDate != null ? endDate : "End Date"}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      onTap: SelectedDay == day.HalfDay ? _offTap : _onTap,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 3.0, color: Colors.black38)
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Componant.commnColor),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: 48,
                            width: double.minPositive,
                            decoration: BoxDecoration(
                              color: SelectedDay == day.FullDay
                                  ? kActivatecardColor
                                  : kInactiveColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              "Full-Day",
                              style: TextStyle(
                                  color: SelectedDay == day.FullDay
                                      ? Colors.white
                                      : Componant.commnColor,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            setState(() {
                              SelectedDay = day.FullDay;
                              getDay = "FullDay";
                            });
                            print(SelectedDay);
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: 48,
                            width: double.minPositive,
                            decoration: BoxDecoration(
                              color: SelectedDay == day.HalfDay
                                  ? kActivatecardColor
                                  : kInactiveColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Half-Day",
                                style: TextStyle(
                                    color: SelectedDay == day.FullDay
                                        ? kTextActivatecardColor
                                        : kTextInactiveColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              SelectedDay = day.HalfDay;
                              getDay = "HalfDay";
                            });
                            print(SelectedDay);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 3.0, color: Colors.black38)
                      ],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                        ),
                        hintText: "Note",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    controller: leaveNoteController,
                    // validator: (value) {
                    //   if (value?.isEmpty) {
                    //     return "Empty value";
                    //   }
                    // },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 3.0, color: Colors.black38)
                      ],
                      borderRadius: BorderRadius.circular(10.0)),
                  // child: BlocBuilder<TeacherLeaveCubit, TeacherLeaveState>(
                  //   builder: (context, state) {
                  //     if (state is TeacherLeaveLoadingState) {
                  //       Text("loading");
                  //     } else if (state is TeacherLeaveSuccessState) {
                  //       final dropReponse = state.response.data;
                  //       print(
                  //           "======================>${dropReponse![0].leaveType}");
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(border: InputBorder.none),
                    value: leaveResionValue,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 28,
                        color: Colors.black38,
                      ),
                    ),
                    items: leaveResion.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            items,
                            style: textStyle,
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Select Leave Reason ",
                        style: textStyle,
                      ),
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         backgroundColor: Colors.red,
                    //         content: Text("Please  Select Leave Reason "),
                    //       ),
                    //     );
                    //   }
                    //   return null;
                    // },
                    onChanged: (newValue) {
                      setState(() {
                        leaveResionValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: BlocConsumer<AddLeaveCubit, AddLeaveState>(
                  listener: (context, state) {
                    if (state is AddLeaveLoadingState) {
                      print("Loading.....");
                    } else if (state is AddLeaveSuccessState) {
                      print(
                          "AddLeaveSuccessState====> ${state.addLeaveResponseModel.toString()}");
                    } else if (state is AddLeaveErrorState) {
                      print("error  => ${state.error}");
                      print(leaveNoteController.text.trim());
                    }
                  },
                  builder: (context, state) {
                    return MaterialButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text(
                        "SUBMIT REQUEST",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      minWidth: 320.0,
                      height: 50.0,
                      color: Componant.commnColor,
                    );
                  },
                ),
              ),
              Visibility(
                replacement: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CircularProgressIndicator(
                      color: Componant.commnColor,
                    )),
                visible: !indicator,
                child: Container(),
              ),
            ]),
          ),
        ),
      ),
    );
  }

// Future<List<String>> getAllCategory() async {
//   if (response.statusCode == 200) {
//     List<String> items = [];
//     var jsonData = json.decode(response.body) as List;
//     for (var element in jsonData) {
//       items.add(element["ClassName"]);
//     }
//     return items;
//   } else {
//     //Handle Errors
//     throw response.statusCode;
//   }
// }
  Widget buidIndicatorContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CircularProgressIndicator(color: Componant.commnColor),
    );
  }
}
