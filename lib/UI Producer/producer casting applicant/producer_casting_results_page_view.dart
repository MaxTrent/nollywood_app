import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/UI%20Producer/producer%20casting%20applicant/producer_casting_applicants_viewmodel.dart';import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/casting_result_widget.dart';
import 'package:pmvvm/pmvvm.dart';

class ProducerCastingResultsPage extends StatelessWidget {
  static String routeName = "/producerCastingResultsPage";
  const ProducerCastingResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerCastingResultsPage(),
      viewModel: locator<ProducerCastingApplicantViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerCastingResultsPage extends StatelessView<ProducerCastingApplicantViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: black,size: 24,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 18.w),
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  border: Border.all(
              color: borderColor, // Change border color when selected
              width: 1,
            ),
                  ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Spacings.spacing6.w,
                    vertical: Spacings.spacing6.h),
                child: SvgPicture.asset(Svgs.trash,height:20.h ,width: 20.w,)
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            BaseText(
              'Village Witch',
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing8.h,
            ),
            BaseText(
              'See all the actors that applied for the village witch role',
               fontSize: TextSizes.textSize14SP,
              fontWeight: FontWeight.w400,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing26.h,
            ),
                ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: CastingResultWidget(
                      
                    ),
                  );
                }),
                SizedBox(
                  height: Spacings.spacing80.h,
                ),
                
            SizedBox(
              height: Spacings.spacing40.h,
            ),
          ],
        ),
      ),
    );
  }
}
