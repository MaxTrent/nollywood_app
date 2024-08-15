import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_profile_circle.dart';

import '../../components/app_searchfield.dart';

class FriendPage extends StatefulWidget {
  static String routeName = "/friendPage";
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          centerTitle: true,
          title: BaseText(
            'Friends',
            fontSize: TextSizes.textSize24SP,
            fontWeight: FontWeight.w700,
            color: black,
          ),
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                labelStyle: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w500),
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w500),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xffEB545D), width: 1.h),
                  insets: EdgeInsets.symmetric(
                      horizontal:
                          100.w), // Adjust as needed to make the line longer
                ),
                controller: tabController,
                tabs: [
                  Tab(
                    text: 'Following 1325',
                  ),
                  Tab(
                    text: 'Followers 89',
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  buildEmptyMessageScreen(context),
                  buildEmptyMessageScreen(context),
                ]),
              )
            ],
          ),
        ));
  }

  GestureDetector buildEmptyMessageScreen(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 21.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppSearchField(
                controller: _searchController,
              ),
            ),
            SizedBox(
              height: Spacings.spacing10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 44.h),
                        child: Row(
                          children: [
                            SvgProfileInCircle(
                              svgAssetPath: 'assets/svgs/profile.svg',
                              circleSize: 48,
                              height: 48.h,
                              width: 48.w,
                            ),
                            SizedBox(width: Spacings.spacing12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Adesua Etomi',
                                    style: TextStyle(
                                      fontSize: TextSizes.textSize14SP.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Satoshi',
                                      color: black,
                                    ),
                                  ),
                                  Text(
                                    '@AdesuaEtomi',
                                    style: TextStyle(
                                      fontSize: TextSizes.textSize14SP.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Satoshi',
                                      color: LightTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Spacings.spacing6.h,
                                      horizontal: Spacings.spacing20.w),
                                  child: BaseText(
                                    'Unfollow',
                                    fontSize: TextSizes.textSize14SP,
                                    fontWeight: FontWeight.w600,
                                    color: white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
