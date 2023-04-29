import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skola/data/home_slider/image_slider_cubit.dart';
import 'package:skola/network/repository/Repository.dart';

import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/entity/slidermodel/sliderResponse.dart';
import '../../network/entity/teacher_leave_model/Data.dart';

class ImageSlider extends StatefulWidget {
  late LoginResponse sharedUser;
  late Repository repository;
  static String route = 'lobby';

  ImageSlider({Key? key, required this.repository, required this.sharedUser})
      : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  void initState() {
    context.read<ImageSliderCubit>().imageSlider(
        int.parse(widget.sharedUser.schoolId.toString()),
        1.0,
        int.parse(widget.sharedUser.userId.toString()),
        "android");
    // TODO: implement initState
    super.initState();
  }

  List<Datum> repoList = [];
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<ImageSliderCubit, ImageSliderState>(
        listener: (context, state) {
          if (state is ImageSliderLoadingState) {
            print("Loading....");
          } else if (state is ImageSliderSuccessState) {
            // final List<Data>? teacherLeaveResponse = state.response.data;
            // repoList.addAll(teacherLeaveResponse as Iterable<Data>);
            final sliderResponse = state.sliderResponse.data;

            repoList.addAll(sliderResponse as Iterable<Datum>);
          }
        },
        builder: (context, state) {
          print("reponseList ==g==>${repoList}");

          return PageView.builder(
              itemCount: repoList.length,
              pageSnapping: true,
              reverse: true,
              onPageChanged: (page) {
                setState(() {});
              },
              itemBuilder: (context, pagePosition) {
                return Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.network(
                      repoList[pagePosition].imageName as String,
                      fit: BoxFit.fitWidth,
                    ));
              });
        },
      ),
    );
    List<Widget> indicators(imagesLength, currentIndex) {
      return List<Widget>.generate(imagesLength, (index) {
        return Container(
          margin: EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: currentIndex == index ? Colors.black : Colors.black26,
              shape: BoxShape.circle),
        );
      });
    }

    int activePage = 1;
  }
}
