// import 'package:flutter/material.dart';
// import 'package:retrofit/http.dart';
// import '../network/entity/model.dart';
// import 'sharedPref.dart';
//
// class Demo extends StatefulWidget {
//   @override
//   DemoView createState() {
//     return DemoView();
//   }
// }
//
// class DemoView extends State<Demo> {
//   SharedPref sharedPref = SharedPref();
//   Post? userSave;
//   Post? userLoad;
//
//   loadSharedPrefs() async {
//     try {
//       Post user = Post.fromJson(await sharedPref.read("user"));
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: new Text("Loaded!"),
//           duration: const Duration(milliseconds: 500)));
//       setState(() {
//         userLoad = user;
//       });
//     } catch (Excepetion) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: new Text("Nothing found!"),
//           duration: const Duration(milliseconds: 500)));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: <Widget>[
//         Container(
//           height: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Container(
//                   height: 50.0,
//                   width: 300.0,
//                   child: TextField(
//                     decoration: InputDecoration(hintText: "Name"),
//                     onChanged: (value) {
//                       setState(() {
//                         userSave!.name = value;
//                       });
//                     },
//                   )),
//               Container(
//                   height: 50.0,
//                   width: 300.0,
//                   child: TextField(
//                     decoration: InputDecoration(hintText: "Age"),
//                     onChanged: (value) {
//                       setState(() {
//                         userSave!.email = value;
//                       });
//                     },
//                   )),
//               Container(
//                   height: 50.0,
//                   width: 300.0,
//                   child: TextField(
//                     decoration: InputDecoration(hintText: "Location"),
//                     onChanged: (value) {
//                       setState(() {
//                         userSave!.schoolname = value;
//                       });
//                     },
//                   )),
//             ],
//           ),
//         ),
//         Container(
//           height: 80.0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   sharedPref.save("user", userSave);
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: new Text("Saved!"),
//                       duration: const Duration(milliseconds: 500)));
//                 },
//                 child: Text('Save', style: TextStyle(fontSize: 20)),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   loadSharedPrefs();
//                 },
//                 child: Text('Load', style: TextStyle(fontSize: 20)),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   sharedPref.remove("user");
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: new Text("Cleared!"),
//                       duration: const Duration(milliseconds: 500)));
//                   setState(() {
//                     userLoad = Post();
//                   });
//                 },
//                 child: Text('Clear', style: TextStyle(fontSize: 20)),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 300.0,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text("Name: " + (userLoad?.name ?? ""),
//                   style: TextStyle(fontSize: 16)),
//               Text("Age: " + (userLoad?.email ?? ""),
//                   style: TextStyle(fontSize: 16)),
//               Text("Location: " + (userLoad?.schoolname ?? ""),
//                   style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
