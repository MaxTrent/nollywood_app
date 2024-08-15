import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/components/app_button.dart';

import '../../../constants/app_colors.dart';
import '../../../gen/assets.gen.dart';

class InvitationSuccess extends StatelessWidget {
  const InvitationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 93.h,
                  ),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomLeft,
                      children: [
                        Transform.rotate(
                          angle: 10 * (pi / 180),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 254.h,
                            width: 169.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),

                                  spreadRadius: 0,

                                  blurRadius: 26.41,

                                  offset: Offset(0, 26.41), // Offset position
                                ),
                              ],
                            ),
                            child: Image.asset(
                              Assets.jpeg.mikoloPoster.path,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          right: 160.w,
                          child: CircleAvatar(
                              radius: 28.r,
                              backgroundColor: selectColor,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 26.r,
                                child: Image.asset(
                                  Assets.png.profilepic.path,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'Congratulations!',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text:
                            'Adesuwa Etomi has been successfully invited to apply for your Mikolo Project as ',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'Village Witch',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                ],
              ),
              Column(
                children: [
                  AppButton(
                    text: 'Send her a message',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.popUntil(
                        context, ModalRoute.withName('/producerProfile')),
                    child: Text(
                      'Go back',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
