import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI Actor/ui.dart';
import 'package:nitoons/UI%20Actor/endorsements/endorsements_vm.dart';
import 'package:nitoons/UI%20Producer/producer_endorsement/producer_endorsements.dart';

import '../../gen/assets.gen.dart';

class Endorsements extends ConsumerWidget {
  const Endorsements({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = EndorsementsViewModel(ref);
    final allEndorsements =
        ref.watch(EndorsementsViewModel.getAllEndorsementsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              height: 1,
              color: Color(0xff3C3C43).withOpacity(0.29),
            )),
        // centerTitle: true,
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
          'All Endorsements',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Subscription())),
                            child: EndorsementTile(
                              index: index,
                            )),
                        SizedBox(
                          height: 41.h,
                        ),
                      ],
                    );
                  }),
              // SizedBox(
              //   height: 24.h,
              // ),
              // GestureDetector(
              //     onTap: () => Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => Subscription())),
              //     child: EndorsementTile()),
              // SizedBox(
              //   height: 41.h,
              // ),
              // EndorsementTile(),
              // SizedBox(
              //   height: 41.h,
              // ),
              // EndorsementTile(),
              // SizedBox(
              //   height: 41.h,
              // ),
              // EndorsementTile(),
              // SizedBox(
              //   height: 41.h,
              // ),
              // EndorsementTile(),
              // SizedBox(
              //   height: 41.h,
              // ),
              // EndorsementTile(),
              // SizedBox(
              //   height: 41.h,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
