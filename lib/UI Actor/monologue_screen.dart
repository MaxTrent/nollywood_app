import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/nav_screens/message_page/message_page.dart';

import '../gen/assets.gen.dart';

class MonologueScreen extends StatefulWidget {
  const MonologueScreen({super.key});

  @override
  State<MonologueScreen> createState() => _MonologueScreenState();
}

class _MonologueScreenState extends State<MonologueScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              height: 1,
              color: Color(0xff3C3C43).withOpacity(0.29),
            )),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.svgs.back,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 24.h,
            width: 24.w,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'All Posts',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MessagePage()));
              },
              icon: SvgPicture.asset(
                Assets.svgs.chat,
                height: 24.h,
                width: 24.w,
              ))
        ],
      ),
      body: Column(
        children: [
          TabBar(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2.h),
              insets: EdgeInsets.symmetric(
                  horizontal:
                      100.w), // Adjust as needed to make the line longer
            ),
            controller: tabController,
            tabs: [
              Tab(
                icon: SvgPicture.asset(Assets.svgs.window,
                    colorFilter: ColorFilter.mode(
                        tabController.index == 0 ? Colors.black : Colors.grey,
                        BlendMode.srcIn)),
              ),
              Tab(
                icon: SvgPicture.asset(Assets.svgs.rose,
                    colorFilter: ColorFilter.mode(
                        tabController.index == 1 ? Colors.black : Colors.grey,
                        BlendMode.srcIn)),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.h,
                    crossAxisSpacing: 1.w,
                  ),
                  itemBuilder: (context, index) => Container(
                        height: 124.h,
                        width: 124.w,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 9.h, right: 5.w),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: SvgPicture.asset(Assets.svgs.video,
                                        height: 14.h, width: 20.w),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h, left: 7.w),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.svgs.rose,
                                    colorFilter: ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 10.h,
                                    width: 11.w,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    '123.9k',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.h,
                    crossAxisSpacing: 1.w,
                  ),
                  itemBuilder: (context, index) => Container(
                        height: 124.h,
                        width: 124.w,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(top: 9.h, right: 5.w),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: SvgPicture.asset(Assets.svgs.video,
                                        height: 14.h, width: 20.w),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h, left: 7.w),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.svgs.rose,
                                    colorFilter: ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: 10.h,
                                    width: 11.w,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    '123.9k',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
            ]),
          )
        ],
      ),
    );
  }
}
