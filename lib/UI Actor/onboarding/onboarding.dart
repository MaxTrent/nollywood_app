import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI Actor/home_page.dart';
import '../../components/components.dart';
import '../../gen/assets.gen.dart';


class Onboarding extends StatefulWidget {
  Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int positionIndex = 0;
  int currentIndex = 0;

  final List<String> images = [
    Assets.png.onboardingpicture1.path,
    Assets.png.onboardingpicture2.path,
    Assets.png.onboardingpicture3.path,
    Assets.png.onboardingpicture4.path,
    Assets.png.onboardingpicture5.path,
    Assets.png.onboardingpicture6.path,
  ];
  final List<String> images2 = [
    Assets.png.onboardingpicture7.path,
    Assets.png.onboardingpicture8.path,
    Assets.png.onboardingpicture9.path,
    Assets.png.onboardingpicture10.path,
    Assets.png.onboardingpicture11.path,
    Assets.png.onboardingpicture12.path,
  ];
  late Timer _timerTop;
  late Timer _timerBottom;
  late ScrollController _scrollControllerTop;
  late ScrollController _scrollControllerBottom;

  @override
  void initState() {
    super.initState();
    _scrollControllerTop = ScrollController();
    _scrollControllerBottom = ScrollController();
    _timerTop = Timer.periodic(Duration(seconds: 1), (timer) {
      _scrollForwardTop();
    });
    _timerBottom = Timer.periodic(Duration(seconds: 1), (timer) {
      _scrollBackwardBottom();
    });
  }

  void _scrollForwardTop() {
    if (_scrollControllerTop.offset >= _scrollControllerTop.position.maxScrollExtent) {
      _scrollControllerTop.animateTo(
        0,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollControllerTop.animateTo(
        _scrollControllerTop.offset + 100,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollBackwardBottom() {
    if (_scrollControllerBottom.offset <= 0) {
      _scrollControllerBottom.animateTo(
          _scrollControllerBottom.position.maxScrollExtent,
          duration: Duration(seconds: 2),
    curve: Curves.easeInOut);
      } else {
      _scrollControllerBottom.animateTo(
        _scrollControllerBottom.offset - 100,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _timerTop.cancel();
    _timerBottom.cancel();
    _scrollControllerTop.dispose();
    _scrollControllerBottom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 13.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SvgPicture.asset(
              Assets.svgs.logotext,
              height: 48.h,
              width: 64.w,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
          Transform.rotate(
            angle: -9 * (pi / 180),
            child: SizedBox(
              height: 150.h,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  controller: _scrollControllerTop,
                  itemBuilder: (context, index) {
                    return Row(
                        children: List.generate(
                            6,
                            (index) => Padding(
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: Container(
                                    height: 115.h,
                                    width: 77.w,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6.r),
                                        color: Colors.grey),
                                    child: Image.asset(
                                      images[index],
                                      fit: BoxFit.fill,
                                      // width: MediaQuery.of(context).size.width / 2 - 16, // Adjust width as needed
                                    ),
                                  ),
                                )));
                  }),
            ),
          ),
          Transform.rotate(
            angle: -9 * (pi / 180),
            child: SizedBox(
              height: 150.h,
              width: double.infinity,
              child: ListView.builder(
                controller: _scrollControllerBottom,
                  scrollDirection: Axis.horizontal,
                  itemCount: images2.length,
                  itemBuilder: (context, index) {
                    return Row(
                        children: List.generate(
                            6,
                                (index) => Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Container(
                                height: 115.h,
                                width: 77.w,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: Colors.grey),
                                child: Image.asset(
                                  images2[index],
                                  fit: BoxFit.fill,
                                  // width: MediaQuery.of(context).size.width / 2 - 16, // Adjust width as needed
                                ),
                              ),
                            )));
                  }),
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            'For actors, directors, and everyone in-between',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 32.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 0.5.h,
                width: 94.w,
                decoration: BoxDecoration(
                  color: Color(0xffC4C4C4),
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
              Text(
                'Start exploring',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 12.sp, color: Color(0xff7C7C7C)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 14.w,
              ),
              Container(
                height: 0.5.h,
                width: 94.w,
                decoration: BoxDecoration(
                  color: Color(0xffC4C4C4),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 22.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
                child: AppButton(
                    width: double.infinity,
                    text: 'Explore as an actor',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    })),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Center(
                child: AppButton(
              width: double.infinity,
              text: 'Explore as a producer',
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ProducerHomePage(),));
              },
              textColor: Colors.black,
              borderColor: Colors.black,
            )),
          ),
        ],
      ),
    ));
  }
}
