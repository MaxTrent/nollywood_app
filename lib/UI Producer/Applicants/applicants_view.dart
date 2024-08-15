import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/custom_profile_circle.dart';

import '../../widgets/produer_casting_applicants_widget.dart';

class ViewApplicantsPage extends StatefulWidget {
  static String routeName = "/viewApplicantsPage";
  const ViewApplicantsPage({super.key});

  @override
  State<ViewApplicantsPage> createState() => _ViewApplicantsPageState();
}

class _ViewApplicantsPageState extends State<ViewApplicantsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final _searchController = TextEditingController();

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
          title: BaseText('Applicants',
          fontSize: TextSizes.textSize24SP,
          fontWeight: FontWeight.w700,
          color: black,
          ),
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios,color: black,),
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
                          24.w), 
                ),
                controller: tabController,
                tabs: [
                  Tab(
                    text: 'All applicants',
                  ),
                  Tab(
                    text: 'Project roles',
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  buildEmptyAllApplicantscreen(context),
                  buildApplicantsRolescreen(context),
                ]),
              )
            ],
          ),
        ));
  }

  GestureDetector buildEmptyAllApplicantscreen(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 21.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),                  shrinkWrap: true,
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 44.h),
                            child: Row(
                              children: [
                                SvgProfileInCircle(svgAssetPath: 'assets/svgs/profile.svg',circleSize: 48,
                                height: 48.h,width: 48.w,
                                ),
                                SizedBox(width: Spacings.spacing12.w),
                                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        'queensheba_5',
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
                                  onTap: (){},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: black,
                                      borderRadius: BorderRadius.all(Radius.circular(8.r))
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(vertical: Spacings.spacing6.h,horizontal: Spacings.spacing20.w),
                                      child: BaseText('View',
                                      fontSize: TextSizes.textSize14SP,
                                      fontWeight: FontWeight.w600,
                                      color: white,),
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
              ]
                      ),
          ),),);
  }

  // for Project Roles
   GestureDetector buildApplicantsRolescreen(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 21.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
                  child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ProducerCastingApplicants(
                      text: "Village witch",
                      amount: '10',
                      press: () {
                        Navigator.pushNamed(
                            context, "/producerCastingResultsPage");
                      },
                    ),
                  );
                }),
                ),
              ]
                      ),
          ),),);
  }
}
