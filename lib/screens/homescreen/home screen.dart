// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skola/component/color.dart';
import 'package:skola/data/home_slider/image_slider_cubit.dart';
import 'package:skola/data/teacher_leave/teacher_leaves_cubit.dart';
import 'package:skola/data/teacher_profile/teacher_profile_cubit.dart';
import 'package:skola/network/entity/LoginResponse/LoginResponse.dart';
import 'package:skola/network/api_client/ApiClient.dart';
// import 'package:dio/dio.dart' show Dio, DioError, FormData;

// import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
// import 'package:skola/screens/fatchdata.dart';
import 'package:skola/screens/login_page/login.dart';

import '../../network/entity/slidermodel/sliderResponse.dart';

import 'package:carousel_slider/carousel_controller.dart';

import '../../network/repository/Repository.dart';
import '../profile/testprofile.dart';
import '../profile/user_profile.dart';
import 'home_card.dart';
import 'imageSlider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
List<String> emptyImage = [];
int _current = 0;
List<Widget>? imageSliders;
final CarouselController _controller = CarouselController();

class HomePage extends StatefulWidget {
  late LoginResponse sharedUser;
  late Repository repository;
  static String route = 'lobby';

  HomePage({Key? key, required this.sharedUser, required this.repository})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var techerprofile;

  @override
  void initState() {
    imageSliders = emptyImage
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              'No. ${emptyImage.indexOf(item)} image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.sharedUser.name.toString()),
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GestureDetector(
                  child: Container(
                    // margin: new EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${widget.sharedUser.photo}',
                      ),
                    ),
                  ),
                  onTap: () {
                    print("userId ===========>${widget.sharedUser.userId}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => TeacherProfileCubit(
                                      repository: widget.repository),
                                  child: UserProfile(
                                    repository: widget.repository,
                                    sharedUser: widget.sharedUser,
                                  ),
                                )));
                  },
                ),
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_active_sharp,
                  color: Colors.amberAccent,
                  size: 31.0,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Column(
              children: [
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: indicators(imgList.length, activePage))
                // Text("${loginPage.user?.email}"),
                // _buildBody(context),

                SizedBox(
                  height: 170,
                  width: double.maxFinite,
                  child: BlocProvider(
                    create: (context) =>
                        ImageSliderCubit(repository: widget.repository),
                    child: ImageSlider(
                      repository: widget.repository,
                      sharedUser: widget.sharedUser,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: HomeCard(
                          repository: widget.repository,
                          sharedUser: widget.sharedUser,
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: emptyImage.asMap().entries.map((entry) {
                //     return GestureDetector(
                //       onTap: () => _controller.animateToPage(entry.key),
                //       child: Container(
                //         width: 12.0,
                //         height: 12.0,
                //         margin:
                //             EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: (Theme.of(context).brightness ==
                //                         Brightness.dark
                //                     ? Colors.white
                //                     : Colors.black)
                //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                //       ),
                //     );
                //   }).toList(),
                // ),
                SizedBox(
                  height: 10.0,
                )
              ],
            ),
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
                    SystemNavigator.pop();
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

  FutureBuilder<SliderResponse?> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions()));
    return FutureBuilder<SliderResponse>(
      future: client.imageSlider(2, 1.0, 4, "android"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data!.msg);
          final SliderResponse? posts = snapshot.data;
          final repoImage = posts?.data;

          for (var i = 0; i < repoImage!.length; i++) {
            print("repoImages ======>${repoImage[i].imageName.toString()}");
            emptyImage.add(repoImage[i].imageName.toString());
          }
          print("--------------empyimage ${emptyImage.length}");
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                    ),
                    items: imageSliders,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
