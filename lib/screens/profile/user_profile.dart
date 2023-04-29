import 'package:flutter/material.dart';

class HomePageWillPop extends StatelessWidget {
  const HomePageWillPop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Home Page"),
        ),
        body:

        Center(
          child: Text(
            "Welcome to Home Page.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
          ),
        ),
      ),
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:skola/component/color.dart';
//
// import '../../component/constant.dart';
// import '../../network/entity/LoginResponse.dart';
// import '../../network/repository/Repository.dart';
//
// class UserProfile extends StatefulWidget {
//   late LoginResponse sharedUser;
//   late Repository repository;
//
//   UserProfile({Key? key, required this.repository, required this.sharedUser})
//       : super(key: key);
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           child: SafeArea(
//             child: Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   Icons.arrow_back,
//                                   color: Colors.white60,
//                                 )),
//                             Positioned(
//                               top: 40,
//                               child: Container(
//                                 height: 45,
//                                 width: 45,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 child: IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.logout,
//                                       color: Componant.commnColor,
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   height: 215,
//                   decoration: BoxDecoration(color: Componant.commnColor),
//                 ),
//                 Positioned(
//                   top: 30,
//                   child: Container(
//                     height: 100.0,
//                     width: 100.0,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.0),
//                         border: Border.all(color: Colors.white)),
//                     // margin: new EdgeInsets.symmetric(horizontal: 4.0),
//                     child: CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         '${widget.sharedUser.photo}',
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 145,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Text(
//                       "${widget.sharedUser.name?.toUpperCase()}",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 5,
//                   right: 5,
//                   top: 180,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           height: 190.0,
//                           width: double.maxFinite,
//                           decoration: BoxDecoration(boxShadow: [
//                             BoxShadow(blurRadius: 5.0, color: Colors.black12),
//                           ], borderRadius: BorderRadius.circular(10.0)),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(10.0), //<-- SEE HERE
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Text(
//                                           "Personal Information",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                               fontSize: 18.0),
//                                         ),
//                                         Icon(
//                                           Icons.person,
//                                           color: Colors.black38,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Contact",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         width: 50.0,
//                                       ),
//                                       Text(
//                                         "Email",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                             color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 50,
//                                           child: Flexible(
//                                             child: Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "${widget.sharedUser.contactNumber1}",
//                                               style: TextStyle(
//                                                   color: Colors.black45),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           "Date Of Birth",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                         SizedBox(
//                                           width: 21.0,
//                                         ),
//                                         Text(
//                                           "Gender",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 50,
//                                           child: Flexible(
//                                             child: Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "",
//                                               style: TextStyle(
//                                                   color: Colors.black45),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           "Address",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                         SizedBox(
//                                           width: 50.0,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 5,
//                   right: 5,
//                   top: 380,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           height: 190.0,
//                           width: double.maxFinite,
//                           decoration: BoxDecoration(boxShadow: [
//                             BoxShadow(blurRadius: 5.0, color: Colors.black12),
//                           ], borderRadius: BorderRadius.circular(10.0)),
//                           child:
//                           Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(10.0), //<-- SEE HERE
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Text(
//                                           "Bank Information",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                               fontSize: 18.0),
//                                         ),
//                                         Icon(
//                                           Icons.house,
//                                           color: Colors.black38,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Bank Name",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         width: 50.0,
//                                       ),
//                                       Text(
//                                         "Account Number",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                             color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 50,
//                                           child: Flexible(
//                                             child: Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "00",
//                                               style: TextStyle(
//                                                   color: Colors.black45),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 70,
//                                         ),
//                                         Container(
//                                           width: 50,
//                                           child: Flexible(
//                                             child: Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "00",
//                                               style: TextStyle(
//                                                   color: Colors.black45),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           "Branch Name",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                         SizedBox(
//                                           width: 21.0,
//                                         ),
//                                         Text(
//                                           "Branch Code",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 50,
//                                           child: Flexible(
//                                             child: Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "00",
//                                               style: TextStyle(
//                                                   color: Colors.black45),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           "Address",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                         SizedBox(
//                                           width: 50.0,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
