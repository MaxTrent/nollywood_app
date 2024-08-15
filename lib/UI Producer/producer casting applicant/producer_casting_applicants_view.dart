import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitoons/config/size_config.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/images.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:nitoons/widgets/main_button.dart';
import 'package:pmvvm/pmvvm.dart';

import 'producer_casting_applicants_viewmodel.dart';

class ProducerCastingApplicantsPage extends StatelessWidget {
  static String routeName = "/producerCastingApplicantsPage";
  const ProducerCastingApplicantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ProducerCastingApplicantsPage(),
      viewModel: locator<ProducerCastingApplicantViewmodel>(),
      disposeVM: false,
    );
  }
}

class _ProducerCastingApplicantsPage
    extends StatelessView<ProducerCastingApplicantViewmodel> {
  @override
  Widget render(context, viewModel) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w,vertical: 14.h),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                IconButton(
            icon: Icon(Icons.arrow_back_ios,size: 24,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 5.w,),
          RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '48 ',
                        style: TextStyle(
                          fontSize: TextSizes.textSize14SP,
                          fontWeight: FontWeight.w700,
                          color: selectColor,
                        )),
                    TextSpan(
                        text: 'applications',
                        style: TextStyle(
                          fontSize: TextSizes.textSize14SP,
                          fontWeight: FontWeight.w400,
                          color: black,
                        )),
                  ],
                ),
              ),
              Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, "/producerListCastingApplicantsPage");
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectColor,
                borderRadius: BorderRadius.all(Radius.circular(45.r)),
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Spacings.spacing16.w,
                    vertical: Spacings.spacing4.h),
                child: BaseText(
                  'See all applicants',
                  fontSize: TextSizes.textSize14SP,
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
              ),
            ),
          ),
              ],
            ),
            BaseText(
              'Mikolo',
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            SizedBox(
              height: Spacings.spacing30.h,
            ),
            Image(
              image: AssetImage(
                Pngs.projectImage,
              ),
              width: Spacings.spacing318.w,
              height: Spacings.spacing386.h,
            ),
            SizedBox(
              height: Spacings.spacing45.h,
            ),
            BaseText(
              'Description',
              fontSize: TextSizes.textSize16SP,
              fontWeight: FontWeight.w700,
              color: black,
              
            ),
            SizedBox(
              height: Spacings.spacing6.h,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Spacings.spacing24.h),
              child: BaseText(
                'Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.Nigerian Teen actors Pamilerin Adegoke (12) and Fiyinfoluwa Asenuga (8) will play lead characters in this live-action feature directed by Niyi Akinmolayan. Other principal casts include Yvonne Jegede, Daniel Etim Effiong, Riyo David, Yomi Elesho and Ayo Mogaji.',
                fontSize: TextSizes.textSize14SP,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            SizedBox(
              height: Spacings.spacing30.h,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: selectColor,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: white,
            context: context,
            builder: (BuildContext context) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacings.spacing24.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Spacings.spacing30.h,
                        ),
                        BaseText(
                          'What do you want to do?',
                          fontSize: TextSizes.textSize18SP,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                        SizedBox(
                          height: Spacings.spacing30.h,
                        ),
                        MainButton(
                          buttonColor: black,
                          textColor: white,
                          text: 'Publish for casting',
                          press: () {
                            Navigator.pushNamed(
                                context, "/producerMonologueCastingTime");
                          },
                        ),
                        SizedBox(
                          height: Spacings.spacing20.h,
                        ),
                        MainButton(
                          buttonColor: white,
                          textColor: black,
                          text: 'Update project details',
                          borderColor: black,
                          press: () {
                            Navigator.pushNamed(
                                context, "/producerCurrentRolePage");
                          },
                        ),
                        SizedBox(
                          height: Spacings.spacing30.h,
                        ),
                      ],
                    ),
                  ));
            },
          );
        },
        child: Center(
          child: SvgPicture.asset(
            Svgs.floationOptions,
            width: 24.w,
            height: 24.h,
            color: Colors.white,
          ),
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
