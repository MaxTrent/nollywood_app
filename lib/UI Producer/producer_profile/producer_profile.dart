import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/nav_screens/message_page/message_page.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../constants/app_colors.dart';
import '../../../gen/assets.gen.dart';
import '../../UI Actor/edit-profile/edit-profile_view.dart';
import '../../UI Actor/profile/profile_view_model.dart';
import '../../locator.dart';

class ProducerProfile extends StatelessWidget {
  const ProducerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<ProfileViewModel>.builder(
        disposeVM: false,
        viewModel: locator<ProfileViewModel>(),
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

// Recent Projects

String formatProjects(List<dynamic> projects) {
          return projects.map((project) {
            return 'Project Name: ${project["project_name"]}, Producer: ${project["producer"]}';
          }).join('\n');
        }

        final recentProjectsString = viewModel.getUserProfileModel?.data != null
            ? formatProjects(viewModel.getUserProfileModel!.data!.recentProjects)
            : '';

            // awards gotten format
            final awards =
    viewModel.getUserProfileModel?.data?.awards.isNotEmpty == true
        ? viewModel.getUserProfileModel!.data!.awards
            .map((award) => award.toString())
            .join(',')
            .replaceAll(RegExp(r'[\s,，,]+'), ', ') 
        : '';

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
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
                'Profile',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfilePage()));
                    },
                    icon: SvgPicture.asset(
                      Assets.svgs.edit,
                      height: 24.h,
                      width: 24.w,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MessagePage()));
                    },
                    icon: SvgPicture.asset(
                      Assets.svgs.settings,
                      height: 24.h,
                      width: 24.w,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProducerProfileInfoTiles(viewModel),
                    SizedBox(
                      height: 31.h,
                    ),
                    Text(
                      'Film maker profile',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
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
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Company Info',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      viewModel.getUserProfileModel?.data != null
                          ? '${viewModel.getUserProfileModel!.data!.companyName}'
                          : '',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      viewModel.getUserProfileModel?.data != null
                          ? '${viewModel.getUserProfileModel!.data!.companyEmail}'
                          : '',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      viewModel.getUserProfileModel?.data != null
                          ? '${viewModel.getUserProfileModel!.data!.companyPhoneNumber}'
                          : '',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
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
                    Text(
                      'Company Location',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
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
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Recent Projects',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                          recentProjectsString,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Education ',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                     viewModel.getUserProfileModel?.data?.education != null &&
                              viewModel
                                  .getUserProfileModel!.data!.education!.isNotEmpty
                          ? '${viewModel.getUserProfileModel!.data!.education.toString()}'
                          : '',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Language ',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
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
                    Text(
                      'Awards',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      awards,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildProducerProfileInfoTiles(ProfileViewModel viewModel) {
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
    return Row(
      children: [
        ProducerProfileInfoTile(
          title: 'Age',
          subtitle:ageString,
        ),
        SizedBox(
          width: 13.w,
        ),
        ProducerProfileInfoTile(
          title: 'Height',
          subtitle: viewModel.getUserProfileModel?.data != null
              ? '${viewModel.getUserProfileModel!.data!.height.toString()}'
              : '',
        ),
        SizedBox(
          width: 13.w,
        ),
        ProducerProfileInfoTile(
          title: 'Gender',
          subtitle:
              '${viewModel.getUserProfileModel?.data?.gender?.toString() ?? ''}',
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
  });

  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      // width: 90.w,
      decoration: BoxDecoration(
          color: selectColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: selectColor)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
