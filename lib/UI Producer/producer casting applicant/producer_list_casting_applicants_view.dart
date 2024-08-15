import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI%20Producer/producer%20casting%20applicant/producer_casting_applicants_viewmodel.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../widgets/produer_casting_applicants_widget.dart';

class ProducerListCastingApplicantsPage extends StatelessWidget {
  static String routeName = "/producerListCastingApplicantsPage";
  const ProducerListCastingApplicantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerListCastingApplicantsPage(),
      viewModel: locator<ProducerCastingApplicantViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerListCastingApplicantsPage
    extends StatelessView<ProducerCastingApplicantViewmodel> {
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
            icon: Icon(
              Icons.arrow_back_ios,color: black,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            BaseText(
              'Casting applicants',
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing32.h,
            ),
            ListView.builder(
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
            SizedBox(
              height: Spacings.spacing116.h,
            ),
          ],
        ),
      ),
    );
  }
}
