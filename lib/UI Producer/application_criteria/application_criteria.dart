import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import '../../../gen/assets.gen.dart';
import '../filtering/filtering.dart';
import '../project_casting_period/producer_monologue_casting_time.dart';
import 'application_criteria_viewmodel.dart';

class ApplicationCriteria extends ConsumerWidget {
  ApplicationCriteria({super.key});

  // static final selectedRolesProvider = StateProvider.autoDispose((ref) => -1);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ApplicationCriteriaViewModel(ref);

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
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Clear',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w700, color: selectColor),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Application criteria',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Set the application criteria for each of the roles you’re casting for',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 28.h,
              ),
              Column(
                  children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 35.h),
                  child: GestureDetector(
                    onTap: () {
                      viewModel.toggleSelection(index);
                    },
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              color: viewModel.isSelected(index)
                                  ? selectColor
                                  : Color(0xffE8E6EA),
                              width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 18.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Adaeze Johnson',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) => Filtering())),
                                child: SvgPicture.asset(
                                  Assets.svgs.filter,
                                  height: 20.h,
                                  width: 20.w,
                                  colorFilter: ColorFilter.mode(
                                      viewModel.isSelected(index)
                                          ? selectColor
                                          : Color(0xffADAFBB),
                                      BlendMode.srcIn),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
        child: AppButton(
          width: double.infinity,
          onPressed: viewModel.isAnyTileSelected(5)
              ? () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProducerMonologueCastingTime(projectId: '', producerId: '',)))
              : null,
          text: 'Proceed',
          backgroundColor:
              viewModel.isAnyTileSelected(5) ? Colors.black : Color(0xffEBECEF),
          textColor:
              viewModel.isAnyTileSelected(5) ? Colors.white : Color(0xff828491),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
