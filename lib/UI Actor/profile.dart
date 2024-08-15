import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/nav_screens/message_page/message_page.dart';
import 'package:nitoons/components/components.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';

import '../constants/app_colors.dart';
import '../gen/assets.gen.dart';
import 'actor_profile_viewmodel.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<ActorProfileViewmodel>.builder(
        disposeVM: false,
        viewModel: locator<ActorProfileViewmodel>(),
        viewBuilder: (_, viewModel) {
          final primaryLanguage = viewModel
                  .getUserProfileModel?.data?.primaryLanguage
                  ?.toString() ??
              '';

          final otherLanguages =
              viewModel.getUserProfileModel?.data?.otherLanguages?.isNotEmpty ==
                      true
                  ? viewModel.getUserProfileModel!.data!.otherLanguages
                      .map((language) => language.toString())
                      .join(',')
                      .replaceAll(RegExp(r'[\s,，,]+'), ', ')
                  : 'English';

          final result = primaryLanguage.isNotEmpty && otherLanguages.isNotEmpty
              ? '$primaryLanguage, $otherLanguages'
              : primaryLanguage + otherLanguages;

// Recent Projects

          String formatProjects(List<dynamic> projects) {
            return projects.map((project) {
              return 'Project Name: ${project["project_name"]}, Producer: ${project["producer"]}';
            }).join('\n');
          }

          final recentProjectsString =
              viewModel.getUserProfileModel?.data != null
                  ? formatProjects(
                      viewModel.getUserProfileModel!.data!.recentProjects)
                  : 'None';

          // awards gotten format
          final awards =
              viewModel.getUserProfileModel?.data?.awards.isNotEmpty == true
                  ? viewModel.getUserProfileModel!.data!.awards
                      .map((award) => award.toString())
                      .join(',')
                      .replaceAll(RegExp(r'[\s,，,]+'), ', ')
                  : '';
                //Stars
          int averageRating =
              viewModel.getUserProfileModel?.data?.averageRating ?? 0;
        
          // actor look alike

          final actorLookAlike = viewModel.getUserProfileModel?.data?.actorLookalike.isNotEmpty == true
        ? viewModel.getUserProfileModel!.data!.actorLookalike
            .map((actorLookalike) => actorLookalike.toString())
            .join(',')
            .replaceAll(RegExp(r'[\s,，,]+'), ', ') 
        : '';

        // link to reels

              final linkToReels = viewModel.getUserProfileModel?.data?.linkToReels.isNotEmpty == true
        ? viewModel.getUserProfileModel!.data!.linkToReels
            .map((linkToReels) => linkToReels.toString())
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
                          builder: (context) => MessagePage()));
                    },
                    icon: SvgPicture.asset(
                      Assets.svgs.chat,
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
                    buildProfileInfoTiles(viewModel),
                    SizedBox(
                      height: 31.h,
                    ),
                    Text(
                      'Average rating',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: SvgPicture.asset(
                            Assets.svgs.star,
                            colorFilter: ColorFilter.mode(
                              index < averageRating ? Colors.red : Colors.grey,
                              BlendMode.srcIn,
                            ),
                            height: 28.h,
                            width: 28.w,
                          ),
                        ),
                      ),
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
                      'Education',
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
                              viewModel.getUserProfileModel!.data!.education!
                                  .isNotEmpty
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
                      'Link to reels ',
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
                          ? '${linkToReels}'
                          : '${viewModel.getUserProfileModel!.data!.linkToReels.length}',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Would you play an extra? ',
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
                          ? '${viewModel.getUserProfileModel!.data!.city}'
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
                    Text(
                      result,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Actor Lookalike ',
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
                          ? '${actorLookAlike}'
                          : '${viewModel.getUserProfileModel!.data!.actorLookalike.length}',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Location ',
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
                          ? '${viewModel.getUserProfileModel!.data!.city}'
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
                          ? '${viewModel.getUserProfileModel!.data!.state}'
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
                          ? '${viewModel.getUserProfileModel!.data!.country}'
                          : '',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Interested roles',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Wrap(
                      children: List.generate(
                        viewModel.getUserProfileModel?.data != null
                            ? viewModel.getUserProfileModel!.data!
                                .preferredRoles.length
                            : 0,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
                          child: PinkTIle(
                            text: viewModel.getUserProfileModel!.data!
                                .preferredRoles[index],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
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
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Text(
                      'Other skills',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Wrap(
                      children: List.generate(
                        viewModel.getUserProfileModel?.data != null
                            ? viewModel.getUserProfileModel!.data!
                                .additionalSkills.length
                            : 0,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
                          child: PinkTIle(
                            text: viewModel.getUserProfileModel!.data!
                                .additionalSkills[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildProfileInfoTiles(ActorProfileViewmodel viewModel) {
    int calculateAge(DateTime birthDate) {
      DateTime now = DateTime.now();
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age;
    }

    String? ageString = (viewModel.getUserProfileModel?.data?.actualAge != null)
        ? calculateAge(viewModel.getUserProfileModel!.data!.actualAge!)
            .toString()
        : '';
    return Row(
      children: [
        ProfileInfoTile(
          title: 'Age',
          subtitle: ageString,
        ),
        SizedBox(
          width: 13.w,
        ),
        ProfileInfoTile(
          title: 'Height',
          subtitle: viewModel.getUserProfileModel?.data != null
              ? '${viewModel.getUserProfileModel!.data!.height.toString()}'
              : '',
        ),
        SizedBox(
          width: 13.w,
        ),
        ProfileInfoTile(
          title: 'Gender',
          subtitle:
              '${viewModel.getUserProfileModel?.data?.gender?.toString() ?? ''}',
        ),
      ],
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  ProfileInfoTile({
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
