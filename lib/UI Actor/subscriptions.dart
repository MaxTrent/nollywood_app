import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/app_button.dart';

import '../gen/assets.gen.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Text(
                'Get unlimited and exclusive access to our pro features',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
              ),
              SizedBox(height: 24.h),
              buildProCard(context),
              SizedBox(
                height: 38.h,
              ),
              AppButton(
                  text: 'Subscribe',
                  backgroundColor: Colors.black,
                  textColor: Colors.white),
              SizedBox(height: 21.h,),
              Text('You will be charged \$9.99 (monthly plan) or \$60.99 (annual plan) through your iTunes account. You can cancel at any time if your not satisfied.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildProCard(BuildContext context) {
    return Container(
      height: 374.h,
      decoration: BoxDecoration(
        color: Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 22.h,
          ),
          Text(
            'POPULAR',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            'Nollywood Actor Pro',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            '\$60.99',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(
            height: 21.h,
          ),
          buildProFeatures(context)
        ],
      ),
    );
  }

  Padding buildProFeatures(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                    color: Color(0xffE8E6EA),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: SvgPicture.asset(Assets.svgs.subcheck),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                'Access to all basic features',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                    color: Color(0xffE8E6EA),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: SvgPicture.asset(Assets.svgs.subcheck),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                'Basic reporting and analytics',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                    color: Color(0xffE8E6EA),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: SvgPicture.asset(Assets.svgs.subcheck),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                'Unlimited group creation',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                    color: Color(0xffE8E6EA),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: SvgPicture.asset(Assets.svgs.subcheck),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                'First picks to producers',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                    color: Color(0xffE8E6EA),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: SvgPicture.asset(Assets.svgs.subcheck),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                'Turn schedule or or off',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
