import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI Actor/top_recommended.dart';

import '../components/components.dart';
import '../gen/assets.gen.dart';

class SelectMonologue extends StatelessWidget {
  SelectMonologue({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Monologue',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 12.h,
                ),
                AppSearchField(
                  hint: 'Search monologues',
                  height: 40,
                  controller: _searchController,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 15.r,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
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
                              'Recommended',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Top recommended',
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
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TopRecommended())),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.h,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
                SizedBox(
                  height: 9.h,
                ),
                MonologueTile(title: 'The Seagull (Anton Chekhov)'),
                SizedBox(
                  height: 9.h,
                ),
                MonologueTile(title: 'The Way of The World (William Congreve)'),
                SizedBox(
                  height: 31.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Category',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18.h,
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Wrap(
                  children: List.generate(
                    9,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
                      child: PinkTIle(
                        text: 'Category ${index + 1}',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 42.h,
                ),
                Row(
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
                              'Trending',
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
                SizedBox(
                  height: 18.h,
                ),
                MonologueTile(title: 'Ruben Guthrie (Brendan Cowell)'),
                SizedBox(
                  height: 9.h,
                ),
                MonologueTile(title: 'Agamemnon (Euripides)'),
                SizedBox(
                  height: 9.h,
                ),
                MonologueTile(
                    title: 'Kiss Me Like You Mean It (Chris Chibnall)'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



