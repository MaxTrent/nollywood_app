import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/edit-profile/edit-profile_viewmodel.dart';
import 'package:nitoons/UI%20Actor/awards/awards.dart';
import 'package:nitoons/UI%20Producer/edit_profile/age_edit_section/age_edit.dart';
import 'package:nitoons/UI%20Producer/edit_profile/company_info/company_info_edit.dart';
import 'package:nitoons/UI%20Producer/edit_profile/company_location_edit.dart/company_location.dart';
import 'package:nitoons/UI%20Producer/edit_profile/education_edit_section/education_edit.dart';
import 'package:nitoons/UI%20Producer/edit_profile/filmmaker_profile_edit_section.dart/filmmaker_profile_edit.dart';
import 'package:nitoons/UI%20Producer/edit_profile/gender_edit_section/gender_edit.dart';
import 'package:nitoons/UI%20Producer/edit_profile/height_edit_section/height_edit.dart';
import 'package:nitoons/UI%20Producer/edit_profile/language_edit_section/language_edit.dart';
import 'package:nitoons/UI%20Producer/edit_profile/recent_project_section/recent_projects_edit.dart';
import 'package:nitoons/components/components.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/constants/sizes.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/widgets/base_text.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../UI Producer/edit_profile/awards_edit_section/awards_edit.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = "/editProfilePage";
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    return MVVM<EditProfileViewmodel>.builder(
      viewModel: locator<EditProfileViewmodel>(),
      disposeVM: false,
      viewBuilder: (_, viewModel) {
         final primaryLanguage =
    viewModel.getUserProfileModel?.data?.primaryLanguage?.toString() ?? '';

final otherLanguages =
    viewModel.getUserProfileModel?.data?.otherLanguages?.isNotEmpty == true
        ? viewModel.getUserProfileModel!.data!.otherLanguages
            .map((language) => language.toString())
            .join(',')
            .replaceAll(RegExp(r'[\s,，,]+'), ', ') 
        : '';

final result = primaryLanguage.isNotEmpty && otherLanguages.isNotEmpty
    ? '$primaryLanguage, $otherLanguages'
    : primaryLanguage + otherLanguages;

print(result);
//awards formats
//  viewModel.getUserProfileModel?.data?.awards != null &&
//                             viewModel
//                                 .getUserProfileModel!.data!.awards.isNotEmpty
//                         ? '${viewModel.getUserProfileModel!.data!.awards.toList().toString()}'
//                         : '',
final awards =
    viewModel.getUserProfileModel?.data?.awards.isNotEmpty == true
        ? viewModel.getUserProfileModel!.data!.awards
            .map((award) => award.toString())
            .join(',')
            .replaceAll(RegExp(r'[\s,，,]+'), ', ') 
        : '';
// Recent Projects

String formatProjects(List<dynamic> projects) {
          return projects.map((project) {
            return 'Project Name: ${project["project_name"]}, Producer: ${project["producer"]}';
          }).join('\n');
        }

        final recentProjectsString = viewModel.getUserProfileModel?.data != null
            ? formatProjects(viewModel.getUserProfileModel!.data!.recentProjects)
            : '';
            
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: white,
            centerTitle: true,
            title: BaseText(
              'Edit profile',
              color: black,
              fontSize: TextSizes.textSize24SP,
              fontWeight: FontWeight.w700,
            ),
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing18.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
            child: SingleChildScrollView(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Spacings.spacing10.h,
                  ),
                  buildProducerProfileEditInfoTiles(viewModel),
                  SizedBox(
                    height: Spacings.spacing10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Film maker profile',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FilmmakerProfileEdit()));
              },
            ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    viewModel.getUserProfileModel?.data != null
                        ? '${viewModel.getUserProfileModel!.data!.filmMakerProfile}'
                        : '',
                    //'Niyi Akinmolayan (listen) is a Nigerian filmmaker and director [1] and one of Nollywood’s most successful hitmakers. Five of his films rank in the top 50 highest grossing Nigerian films: The Wedding Party 2 (2017) Chief Daddy (2018), Prophetess (2021), My Village People (2021), and The Set Up (2019). He is also the founder and Creative Director of Anthill Studios, a media production facility. In January 2022, Anthill Studios signed a multi-year deal with Amazon Prime Video to become the exclusive global streaming home for Anthill’s slate of cinema releases following their theatrical runs in Nigeria.[2]',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Company Info',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CompanyInfoEdit()));
              },
            ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    viewModel.getUserProfileModel?.data != null
                        ? '${viewModel.getUserProfileModel!.data!.companyName}'
                        : '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    viewModel.getUserProfileModel?.data != null
                        ? '${viewModel.getUserProfileModel!.data!.companyEmail}'
                        : '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    viewModel.getUserProfileModel?.data != null
                        ? '${viewModel.getUserProfileModel!.data!.companyPhoneNumber}'
                        : '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // Text(
                  //   viewModel.getUserProfileModel?.data != null
                  //                 ? '${viewModel.getUserProfileModel!.data!.companyEmail}'
                  //                 : '',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .displaySmall!
                  //       .copyWith(
                  //           fontWeight: FontWeight.w400,
                  //           color: Color(0xff757575)),
                  // ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Company Location',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CompanyLocationEdit()));
              },
            ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    viewModel.getUserProfileModel?.data != null
                        ? '${viewModel.getUserProfileModel!.data!.address}'
                        : '',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    viewModel.getUserProfileModel?.data != null
                        ? '${viewModel.getUserProfileModel!.data!.state.toString()}, ${viewModel.getUserProfileModel!.data!.country.toString()}'
                        : '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Projects',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RecentProjectsEdit()));
              },
            ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    recentProjectsString,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Education ',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EducationEdit()));
              },
            ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    viewModel.getUserProfileModel?.data?.education != null &&
                            viewModel.getUserProfileModel!.data!.education!
                                .isNotEmpty
                        ? '${viewModel.getUserProfileModel!.data!.education.toString()}'
                        : '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Language ',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LanguageEdit()));
              },
            ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Define the logic outside the Text widget

// Use the result inside the Text widget
                  Text(
                    result,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575),
                        ),
                  ),

                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Awards',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AwardsEdit()));
              },
            ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    awards,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //               Container(
                  //                 child: ListView.builder(
                  //                     physics: NeverScrollableScrollPhysics(),
                  //                     shrinkWrap: true,
                  //                     itemCount: viewModel.profileEditList.length,
                  //                     itemBuilder: (context, index) {
                  //                       return ProfileEditWidget(
                  //                          title: viewModel.profileEditList[index]["title"].toString(),
                  //                         subtitle: viewModel.profileEditList[index]["subtitle"].toString(),
                  //                         subtitleTwo: (viewModel.profileEditList[index]["subtitleTwo"] ?? "").toString().isEmpty
                  // ? " "
                  // : viewModel.profileEditList[index]["subtitleTwo"].toString(),
                  //                       );
                  //                     }),
                  //               ),

                  SizedBox(
                    height: Spacings.spacing8.h,
                  ),
                  SizedBox(
                    height: Spacings.spacing24.h,
                  ),
                  SizedBox(
                    height: Spacings.spacing24.h,
                  ),
                  
                  SizedBox(
                    height: Spacings.spacing2.h,
                  ),
                  SizedBox(
                    height: Spacings.spacing10.h,
                  ),
                  SizedBox(
                    height: Spacings.spacing40.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProducerProfileEditInfoTiles(EditProfileViewmodel viewModel) {
    
    // age calculation 
            int calculateAge(DateTime birthDate) {
  DateTime now = DateTime.now();
  int age = now.year - birthDate.year;
  if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  return age;
}

String? ageString = (viewModel.getUserProfileModel?.data?.actualAge != null)
    ? calculateAge(viewModel.getUserProfileModel!.data!.actualAge!).toString()
    : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProducerProfileInfoTile(
          title: 'Age',
          subtitle:ageString,
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AgeEdit()));
          },
        ),
        SizedBox(
          width: 13.w,
        ),
        ProducerProfileInfoTile(
          title: 'Height',
          subtitle: viewModel.getUserProfileModel?.data != null
              ? '${viewModel.getUserProfileModel!.data!.height.toString()}'
              : '',
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HeightEdit()));
          },
        ),
        SizedBox(
          width: 13.w,
        ),
        ProducerProfileInfoTile(
          title: 'Gender',
          subtitle:
              '${viewModel.getUserProfileModel?.data?.gender?.toString() ?? ''}',
          press: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => GenderEdit()));
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ProfileEditWidget extends StatelessWidget {
  ProfileEditWidget(
      {required this.subtitle,
      this.subtitleTwo,
      required this.title,
      super.key});
  String title;
  String subtitle;
  String? subtitleTwo;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              title,
              fontSize: TextSizes.textSize16SP,
              fontWeight: FontWeight.w700,
              color: black,
            ),
            IconButton(
              icon: Image.asset(
                'assets/png/edit.png',
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/notificationsPage');
              },
            ),
          ],
        ),
        BaseText(
          subtitle,
          fontSize: TextSizes.textSize14SP,
          fontWeight: FontWeight.w400,
          color: LightTextColor,
        ),
        BaseText(
          subtitleTwo!,
          fontSize: TextSizes.textSize14SP,
          fontWeight: FontWeight.w400,
          color: LightTextColor,
        ),
      ],
    );
  }
}

class ProducerProfileInfoTile extends StatelessWidget {
  ProducerProfileInfoTile({
    required this.title,
    required this.subtitle,
    super.key,
    required this.press,
  });

  String title;
  String subtitle;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            IconButton(
                icon: Image.asset(
                  'assets/png/edit.png',
                  height: 24.h,
                  width: 24.w,
                ),
                onPressed: press),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
