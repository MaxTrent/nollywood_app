import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI Actor/ui.dart';
import 'package:nitoons/UI%20Producer/producer%20Endorse%20rate%20and%20review/producer_endorse_rate_and_review.dart';
import 'package:nitoons/UI%20Producer/producer_endorsement/producer_endorsements_vm.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/utilities/app_util.dart';
import 'package:nitoons/widgets/app_star_rating.dart';
import '../../gen/assets.gen.dart';

class ProducerEndorsements extends ConsumerWidget {
  const ProducerEndorsements({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ProducerEndorsementsViewModel(ref);
    final allEndorsements =
        ref.watch(ProducerEndorsementsViewModel.getAllEndorsementsProvider);

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProducerEndorseRateandReviewPage())),
                child: SvgPicture.asset(Assets.svgs.createEndorsement)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Expanded(
                child: ListView.builder(
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
              ),
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

class EndorsementTile extends ConsumerWidget {
  EndorsementTile({
    required this.index,
    super.key,
  });

  int index;

  @override
  Widget build(BuildContext context, ref) {
    final allEndorsements =
        ref.watch(ProducerEndorsementsViewModel.getAllEndorsementsProvider);

    return allEndorsements.when(data: (data) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(Assets.png.profilepic.path),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Adesua Etomi',
                        data.data.results[index].id,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        // '@AdesuaEtomi',
                        data.data.results[index].id,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff757575)),
                      ),
                    ],
                  ),
                ],
              ),
              AppStarRating(
                isStarClickable: false,
                numberOfStars: 5,
                starColor: switchNotActive,
                initialRating: data.data.results[index].rating,
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
              // 'I bought it…I bought it! One moment…wait…if you would, ladies and gentlemen… My head’s going round and round, I can’t speak… (laughs). So now the cherry orchard is mine! Mine! (he gives a shout of laughter) Great God in heaven – the cherry orchard is mine! T',
              data.data.results[index].comment,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  )),
        ],
      );
    }, error: (error, _) {
      AppUtils.debug(error.toString());
      AppUtils.debug(_.toString());
      return Text(
        'No Endorsements',
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontWeight: FontWeight.w400, color: Color(0xff757575)),
      );
    }, loading: () {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(Assets.png.profilepic.path),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Adesua Etomi',
                        '',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '@AdesuaEtomi',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff757575)),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: List.generate(
                    5,
                    (index) => Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: SvgPicture.asset(
                            Assets.svgs.star,
                            height: 14.h,
                            width: 14.w,
                          ),
                        )),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
              'I bought it…I bought it! One moment…wait…if you would, ladies and gentlemen… My head’s going round and round, I can’t speak… (laughs). So now the cherry orchard is mine! Mine! (he gives a shout of laughter) Great God in heaven – the cherry orchard is mine! T',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  )),
        ],
      );
    });
  }
}
