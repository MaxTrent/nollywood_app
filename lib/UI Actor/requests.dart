import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../gen/assets.gen.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

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
        title: Text(
          'Requests',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svgs.chatbubble,
              colorFilter: ColorFilter.mode(Color(0xffADAFBB), BlendMode.srcIn),
            ),
            SizedBox(height: 34.h,),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                  text: 'You currently have no projects.',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                        text: '\nClick here',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                          color: selectColor,
                        )),
                    TextSpan(text: ' to add a project')
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
