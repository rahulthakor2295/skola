// import 'dart:convert';
//
// import 'package:http/http.dart' as http ;
//
// import 'model.dart';
// class RemoteServices{
//   User user = User();
// Future<List<User>> getData()async{
//   var uri =Uri.parse("http://school.paperbirdtech.com/api/Teacher/login.php");
// final response = await http.get(uri);
// if (response.statusCode == 200) {
//   final List result = json.decode(response.body);
//   return result.map((e) => User.fromJson(e)).toList();
// } else {
// }
//
// // var response=await http.post(uri);
// // if(response.statusCode == 200){
// // var data = User.fromJson(jsonDecode(response.body));
// // return data;
// }
// }
//
