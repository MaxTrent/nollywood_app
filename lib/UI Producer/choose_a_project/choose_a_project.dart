import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/app_button.dart';
import 'package:nitoons/constants/app_colors.dart';
import 'package:nitoons/locator.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../../gen/assets.gen.dart';
import '../../data/app_storage.dart';
import '../../models/producer_projectects.dart';
import '../choose_role/choose_role.dart';
import 'choose_a_project_vm.dart';

class ChooseAProject extends StatelessWidget {
  const ChooseAProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _ChooseAProject(),
      viewModel: locator<ChooseAProjectViewModel>(),
      disposeVM: false,
    );
  }
}

class _ChooseAProject extends StatelessView<ChooseAProjectViewModel> {
  @override
  Widget render(context, viewModel) => Scaffold(
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose a project',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Which of your projects would you like to invite Adesuwa Etomi to apply for?',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 28.h,
                ),
                FutureBuilder<List<Data>>(
                  future: viewModel.fetchAllProducerProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(black),
                      ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.svgs.emptybox),
                            SizedBox(
                              height: 34.h,
                            ),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'You currently have no Projects.',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w400),
                                children: [],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final projects = snapshot.data!;
                      return Container(
                        height: MediaQuery.of(context).size.height *
                            0.7, // Set a bounded height for the GridView
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 0.65),
                          itemCount: projects.length,
                          itemBuilder: (BuildContext context, int index) {
                            final project = projects[index];
                            return GestureDetector(
                              onTap: () {
                                viewModel.selectProject(index, projects);
                                SharedPreferencesHelper.storeProducerProjectId(
                                    project.sId.toString());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.h),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.r),
                                      border: Border.all(
                                          color: viewModel.isSelected(index)
                                              ? selectColor
                                              : Colors.transparent,
                                          width: viewModel.isSelected(index)
                                              ? 3
                                              : 0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: Image.network(
                                        project.thumbnail.toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 192.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    project.projectName!.length > 25
                                        ? project.projectName!
                                                .substring(0, 23) +
                                            '...'
                                        : project.projectName!.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
          child: AppButton(
            width: double.infinity,
            onPressed: () {
              final selectedProjectId = viewModel.selectedProjectId;
              final selectedProjectName = viewModel.selectedProjectName;
              print(selectedProjectName);
              print(selectedProjectId);
              if (selectedProjectId != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseRole(
                        projectId: selectedProjectId,
                        projectName: selectedProjectName.toString()),
                  ),
                );
              }
            },
            text: 'Proceed',
            backgroundColor: viewModel.selectedProjectIndex == -1
                ? Color(0xffEBECEF)
                : black,
            textColor: viewModel.selectedProjectIndex == -1
                ? Color(0xff828491)
                : white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}
