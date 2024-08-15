import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/components/app_searchfield.dart';

import '../../gen/assets.gen.dart';

class Search extends StatelessWidget {
  Search({super.key});

  final _controller = TextEditingController();
  final searchMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Padding(
          padding: EdgeInsets.only(right: 24.w),
          child: AppSearchField(
            height: 40,
            controller: _controller,
          ),
        ),
      ),
      body: searchMatch
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 34.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildProfilePicture(),
                            SizedBox(
                              width: 13.w,
                            ),
                            buildNameAndUserName(context),
                          ],
                        ),
                        AppButton(
                            height: 31.h,
                            // width: 85.w,
                            text: 'Follow',
                            backgroundColor: Colors.black,
                            fontSize: 13,
                            textColor: Colors.white)
                      ],
                    ),
                  ),
                  SizedBox(height: 46.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 34.h,
                              width: 34.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff161823).withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  Assets.svgs.hashtag,
                                  height: 15.h,
                                  width: 13.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Monologues',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Trending monologues',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff8A8B8F)),
                                )
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, builder) => Padding(
                                padding: EdgeInsets.only(right: 3.w),
                                child: Container(
                                  height: 148.h,
                                  width: 109.w,
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 8.h, left: 7.w),
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 34.h,
                              width: 34.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff161823).withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  Assets.svgs.hashtag,
                                  height: 15.h,
                                  width: 13.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Actors',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Trending actors',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff8A8B8F)),
                                )
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, builder) => Padding(
                                padding: EdgeInsets.only(right: 3.w),
                                child: Container(
                                  height: 148.h,
                                  width: 109.w,
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 8.h, left: 7.w),
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 34.h,
                              width: 34.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff161823).withOpacity(0.12)),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  Assets.svgs.hashtag,
                                  height: 15.h,
                                  width: 13.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Producers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Trending producers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff8A8B8F)),
                                )
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, builder) => Padding(
                                padding: EdgeInsets.only(right: 3.w),
                                child: Container(
                                  height: 148.h,
                                  width: 109.w,
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 8.h, left: 7.w),
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 139.h,
                  ),
                  Text(
                    'Sorry!',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'There are no actors matching the search parameters you entered',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff828693)),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                      child: AppButton(
                    text: 'Try again',
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    textColor: Colors.black,
                    borderColor: Colors.black,
                  )),
                ],
              ),
            ),
    );
  }

  Column buildNameAndUserName(BuildContext context) {
    return Column(
      children: [
        Text(
          'Adesua Etomi',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          'queensheba_5',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w400, color: Color(0xffADAFBB)),
        ),
      ],
    );
  }

  CircleAvatar buildProfilePicture() {
    return CircleAvatar(
      radius: 28.r,
      backgroundColor: Color(0xffE8E6EA),
      child: CircleAvatar(
        radius: 24.r,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: Color(0xffE8E6EA),
          child: CircleAvatar(
            radius: 18.r,
            child: Image.asset(Assets.png.profilepic.path),
          ),
        ),
      ),
    );
  }
}
