import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nitoons/UI%20Actor/home_page.dart';
import 'package:nitoons/UI%20Actor/project/project_view.dart';
import 'package:nitoons/UI%20Actor/roles/roles_vm.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/widgets/project_shimmer.dart';
import '../../components/app_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/sizes.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/base_text.dart';


class Roles extends HookConsumerWidget {
  Roles({super.key});



  @override
  Widget build(BuildContext context, ref) {
    final viewModel = RolesViewModel(ref);
    final allOpenRoles = ref.watch(RolesViewModel.getAllOpenRolesProvider);
    final allApplications =
        ref.watch(RolesViewModel.getAllApplicationsProvider);


    // ref.refresh(RolesViewModel.getAllOpenRolesProvider);


    // viewModel.g
    // ref.read(RolesViewModel.getAllOpenRolesProvider);

//
// if (allApplications.value!.error || allApplications.value!.data == null){
//   if (allApplications.value!.code == 400){
//     context.showSignUpModal();
//   }
//
//     }


    return allOpenRoles.when(data: (openRoles) {
     if (openRoles.error && openRoles.data == null) {
        if (openRoles.code == 400) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ref.read(isModalShownProvider)){
              context.showSignUpModal(ref);
              ref.read(isModalShownProvider.notifier).state = true;
            }
          });
          return Scaffold(
            body: Center(
              child: LoginButton(),
            ),
          );
        }}
        return Scaffold(
            appBar: AppBar(
              leadingWidth: 150.w,
              leading: Padding(
                padding: EdgeInsets.only(left: 23.w),
                child: Center(
                  child: Text(
                    'Roles',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 23.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.svgs.blackbell),
                      SizedBox(
                        width: 18.w,
                      ),
                      SvgPicture.asset(Assets.svgs.doublearrow)
                    ],
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                // shrinkWrap: true,
                //  physics: BouncingScrollPhysics(),
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
                      borderSide: BorderSide(color: selectColor, width: 1.h),
                      insets: EdgeInsets.symmetric(horizontal: 10.w ?? 100.w),
                    ),
                    controller: viewModel.tabController,
                    tabs: [
                      Tab(
                        text: 'Open roles',
                      ),
                      Tab(
                        text: 'My Applications',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child:
                    TabBarView(controller: viewModel.tabController, children: [
                      buildOpenRolesScreen(context, ref),
                      buildApplicationsScreen(context, ref),
                    ]),
                  )
                ],
              ),
            ));
    }, error: (error, _){
      print('$error $_');
      return Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(child: Text('An Error Occured: $error')),
        ),
      );
    }, loading: (){
      return Center(child: AppLoadingIndicator());
    });

  }

  Widget buildOpenRolesScreen(BuildContext context, WidgetRef ref) {
    final allOpenRoles = ref.watch(RolesViewModel.getAllOpenRolesProvider);

    // if (allOpenRoles.value?.code == 400) {
    //   print('do somethinggggg');
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => SignUpPage()));
    //   });
    //   return Container();
    // }

    return allOpenRoles.when(data: (openRoles) {

      if (openRoles.error || openRoles.data == null) {

        // if (openRoles.code == 400) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => SignUpPage()));
        //   });
        //   return Container();
        // }
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.svgs.emptyroles,
                    height: 82.h,
                    width: 96.w,
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  Text(
                      'Seems there are no projects with open roles you’re eligible to apply for at this time. You can always check back at any time.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w400)),
                  // GestureDetector(
                  //   onTap: () => Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => SignUpPage())),
                  //   child: Text.rich(
                  //     textAlign: TextAlign.center,
                  // TextSpan(
                  //     text: 'You currently have no projects.',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .displayMedium!
                  //         .copyWith(fontWeight: FontWeight.w400),
                  //     children: [
                  //       TextSpan(
                  //           text: '\nClick here',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .displayMedium!
                  //               .copyWith(
                  //                 fontWeight: FontWeight.w700,
                  //                 color: selectColor,
                  //               )),
                  //       TextSpan(text: ' to add a project')
                  //     ]),
                  //         ),
                  //       )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
            backgroundColor: selectColor,
          ),
        );


      }

      if (openRoles.data == [] || openRoles.data!.isEmpty) {
        return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.svgs.emptyroles,
                        height: 82.h,
                        width: 96.w,
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      Text(
                          'Seems there are no projects with open roles you’re eligible to apply for at this time. You can always check back at any time.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w400)),
                      // GestureDetector(
                      //   onTap: () => Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => SignUpPage())),
                      //   child: Text.rich(
                      //     textAlign: TextAlign.center,
                      // TextSpan(
                      //     text: 'You currently have no projects.',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .displayMedium!
                      //         .copyWith(fontWeight: FontWeight.w400),
                      //     children: [
                      //       TextSpan(
                      //           text: '\nClick here',
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .displayMedium!
                      //               .copyWith(
                      //                 fontWeight: FontWeight.w700,
                      //                 color: selectColor,
                      //               )),
                      //       TextSpan(text: ' to add a project')
                      //     ]),
                      //         ),
                      //       )
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
                backgroundColor: selectColor,
              ),
            ));
      }



      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.65),
              itemCount: openRoles.data!.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectPage(
                          projectId: openRoles.data![index].projectId,
                          roleId: openRoles.data![index].id,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 192.h,
                          width: 158.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.grey,
                          ),
                          child: Image.network(
                            // Assets.png.mikolo.path,
                            openRoles.data![index].thumbnailUrl,
                            fit: BoxFit.fill,

                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        openRoles.data![index].roleName,
                        // application.projectName.length > 30
                        //     ? application.projectName.substring(0, 25) + '...'
                        //     : application.projectName.toString(),
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      Text(
                        // application.producerName.length > 30
                        //     ? application.projectName.substring(0, 25) + '...'
                        //     : application.projectName.toString(),
                        // 'Kunle Afolayan',
                        openRoles.data![index].producerName,
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                    ],
                  ),
                );
              },
            )),
      );
    }, error: (error, _) {
      return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.svgs.emptyroles,
                      height: 82.h,
                      width: 96.w,
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Text(
                      'An Error Occurred',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w400)),
                    // GestureDetector(
                    //   onTap: () => Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => SignUpPage())),
                    //   child: Text.rich(
                    //     textAlign: TextAlign.center,
                    // TextSpan(
                    //     text: 'You currently have no projects.',
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .displayMedium!
                    //         .copyWith(fontWeight: FontWeight.w400),
                    //     children: [
                    //       TextSpan(
                    //           text: '\nClick here',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .displayMedium!
                    //               .copyWith(
                    //                 fontWeight: FontWeight.w700,
                    //                 color: selectColor,
                    //               )),
                    //       TextSpan(text: ' to add a project')
                    //     ]),
                    //         ),
                    //       )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r)),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
              backgroundColor: selectColor,
            ),
          ));

      // return Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      //   child: GestureDetector(
      //       onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      //       child: GridView.builder(
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2,
      //             crossAxisSpacing: 10.0,
      //             mainAxisSpacing: 10.0,
      //             childAspectRatio: 0.65),
      //         itemCount: 12,
      //         shrinkWrap: true,
      //         itemBuilder: (BuildContext context, int index) {
      //           return GestureDetector(
      //               onTap: () {
      //                 // Navigator.push(
      //                 //   context,
      //                 //   MaterialPageRoute(
      //                 //     builder: (context) => ProjectDetails(),
      //                 //   ),
      //                 // );
      //               },
      //               child: Text(error.toString(),
      //                   style: Theme.of(context)
      //                       .textTheme
      //                       .displayMedium!
      //                       .copyWith(fontWeight: FontWeight.w400)));
      //         },
      //       )),
      // );
    }, loading: () {
      return ProjectShimmer();
    });

    // return GestureDetector(
    //     onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
    //     child: Scaffold(
    //       body: Center(
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 24.w),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               SvgPicture.asset(
    //                 Assets.svgs.emptyroles,
    //                 height: 82.h,
    //                 width: 96.w,
    //               ),
    //               SizedBox(
    //                 height: 34.h,
    //               ),
    //               Text(
    //                   'Seems there are no projects with open roles you’re eligible to apply for at this time. You can always check back at any time.',
    //                   textAlign: TextAlign.center,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .displayMedium!
    //                       .copyWith(fontWeight: FontWeight.w400)),
    //               // GestureDetector(
    //               //   onTap: () => Navigator.push(context,
    //               //       MaterialPageRoute(builder: (context) => SignUpPage())),
    //               //   child: Text.rich(
    //               //     textAlign: TextAlign.center,
    //               // TextSpan(
    //               //     text: 'You currently have no projects.',
    //               //     style: Theme.of(context)
    //               //         .textTheme
    //               //         .displayMedium!
    //               //         .copyWith(fontWeight: FontWeight.w400),
    //               //     children: [
    //               //       TextSpan(
    //               //           text: '\nClick here',
    //               //           style: Theme.of(context)
    //               //               .textTheme
    //               //               .displayMedium!
    //               //               .copyWith(
    //               //                 fontWeight: FontWeight.w700,
    //               //                 color: selectColor,
    //               //               )),
    //               //       TextSpan(text: ' to add a project')
    //               //     ]),
    //               //         ),
    //               //       )
    //             ],
    //           ),
    //         ),
    //       ),
    //       floatingActionButton: FloatingActionButton(
    //         onPressed: () {},
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(30.r)),
    //         child: Icon(
    //           Icons.add,
    //           color: Colors.white,
    //           size: 35,
    //         ),
    //         backgroundColor: selectColor,
    //       ),
    //     ));

    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
    //   child: GestureDetector(
    //       onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
    //       child: Expanded(
    //         child: GridView.builder(
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2,
    //               crossAxisSpacing: 10.0,
    //               mainAxisSpacing: 10.0,
    //               childAspectRatio: 0.65),
    //           itemCount: 12,
    //           shrinkWrap: true,
    //           itemBuilder: (BuildContext context, int index) {
    //             return GestureDetector(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //   context,
    //                 //   MaterialPageRoute(
    //                 //     builder: (context) => ProjectDetails(),
    //                 //   ),
    //                 // );
    //               },
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   SizedBox(height: 8.h),
    //                   Expanded(
    //                     child: Container(
    //                       clipBehavior: Clip.hardEdge,
    //                       height: 192.h,
    //                       width: 158.w,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(8.r),
    //                         color: Colors.grey,
    //                       ),
    //                       child: Image.asset(
    //                         Assets.png.mikolo.path,
    //                         fit: BoxFit.fill,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(height: 8.h),
    //                   Text(
    //                     'Mikolo',
    //                     // application.projectName.length > 30
    //                     //     ? application.projectName.substring(0, 25) + '...'
    //                     //     : application.projectName.toString(),
    //                     style:
    //                         Theme.of(context).textTheme.displayMedium!.copyWith(
    //                               fontWeight: FontWeight.w700,
    //                             ),
    //                   ),
    //                   Text(
    //                     // application.producerName.length > 30
    //                     //     ? application.projectName.substring(0, 25) + '...'
    //                     //     : application.projectName.toString(),
    //                     'Kunle Afolayan',
    //                     style:
    //                         Theme.of(context).textTheme.displaySmall!.copyWith(
    //                               fontWeight: FontWeight.w400,
    //                             ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       )),
    // );
  }

  Widget buildApplicationsScreen(BuildContext context, WidgetRef ref) {
    final allApplications =
        ref.watch(RolesViewModel.getAllApplicationsProvider);



    return allApplications.when(data: (applications) {
      if (applications.error || applications.data == null) {

        // if (applications.code == 400) {
        //   print('do somethinggggg');
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => SignUpPage()));
        //   });
        //   return Container();
        // }
        // return Text("No applications available",
        //     textAlign: TextAlign.center,
        //     style: Theme.of(context)
        //         .textTheme
        //         .displayMedium!
        //         .copyWith(fontWeight: FontWeight.w400));


        return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.svgs.emptyroles),
                  SizedBox(
                    height: 34.h,
                  ),
                  Text(
                      'Seems you haven’t applied for any roles yet. When you apply for roles, you’ll see a list of your applications here.',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w400)),
                  // GestureDetector(
                  //   onTap: () => Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => SignUpPage())),
                  //   child: Text.rich(
                  //     textAlign: TextAlign.center,
                  // TextSpan(
                  //     text: 'You currently have no projects.',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .displayMedium!
                  //         .copyWith(fontWeight: FontWeight.w400),
                  //     children: [
                  //       TextSpan(
                  //           text: '\nClick here',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .displayMedium!
                  //               .copyWith(
                  //                 fontWeight: FontWeight.w700,
                  //                 color: selectColor,
                  //               )),
                  //       TextSpan(text: ' to add a project')
                  //     ]),
                  //         ),
                  //       )
                ],
              ),
            ),



        );



      }


      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.65),
              itemCount: applications.data!.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final application = applications.data![index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProjectDetails(),
                    //   ),
                    // );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 192.h,
                          width: 158.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.grey,
                          ),
                          child: Image.network(
                            application.thumbnailUrl ?? '',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        application.projectName!.length > 30
                            ? application.projectName!.substring(0, 25) + '...'
                            : application.projectName.toString(),
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      Text(
                        application.producerName!.length > 30
                            ? application.projectName!.substring(0, 25) + '...'
                            : application.projectName.toString(),
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                    ],
                  ),
                );
              },
            )),
      );
    }, error: (error, _) {
      print('$error:: $_');
      return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.svgs.emptyroles),
                  SizedBox(
                    height: 34.h,
                  ),
                  Text(
                      'An error occured: $error',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w400)),
                  // GestureDetector(
                  //   onTap: () => Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => SignUpPage())),
                  //   child: Text.rich(
                  //     textAlign: TextAlign.center,
                  // TextSpan(
                  //     text: 'You currently have no projects.',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .displayMedium!
                  //         .copyWith(fontWeight: FontWeight.w400),
                  //     children: [
                  //       TextSpan(
                  //           text: '\nClick here',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .displayMedium!
                  //               .copyWith(
                  //                 fontWeight: FontWeight.w700,
                  //                 color: selectColor,
                  //               )),
                  //       TextSpan(text: ' to add a project')
                  //     ]),
                  //         ),
                  //       )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r)),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
              backgroundColor: selectColor,
            ),
          ));

      // return GestureDetector(
      //     onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      //     child: Scaffold(
      //       body: Center(
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 24.w),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               SvgPicture.asset(Assets.svgs.emptyroles),
      //               SizedBox(
      //                 height: 34.h,
      //               ),
      //               Text(error.toString(),
      //                   style: Theme.of(context)
      //                       .textTheme
      //                       .displayMedium!
      //                       .copyWith(fontWeight: FontWeight.w400)),
      //             ],
      //           ),
      //         ),
      //       ),
      //       floatingActionButton: FloatingActionButton(
      //         onPressed: () {},
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(30.r)),
      //         child: Icon(
      //           Icons.add,
      //           color: Colors.white,
      //           size: 35,
      //         ),
      //         backgroundColor: selectColor,
      //       ),
      //     ));
    }, loading: () {
      return AppLoadingIndicator();
    });

    // return GestureDetector(
    //     onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
    //     child: Scaffold(
    //       body: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             SvgPicture.asset(Assets.svgs.emptyroles),
    //             SizedBox(
    //               height: 34.h,
    //             ),
    //             Text(
    //                 'Seems you haven’t applied for any roles yet. When you apply for roles, you’ll see a list of your applications here.',
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .displayMedium!
    //                     .copyWith(fontWeight: FontWeight.w400)),
    //             // GestureDetector(
    //             //   onTap: () => Navigator.push(context,
    //             //       MaterialPageRoute(builder: (context) => SignUpPage())),
    //             //   child: Text.rich(
    //             //     textAlign: TextAlign.center,
    //             // TextSpan(
    //             //     text: 'You currently have no projects.',
    //             //     style: Theme.of(context)
    //             //         .textTheme
    //             //         .displayMedium!
    //             //         .copyWith(fontWeight: FontWeight.w400),
    //             //     children: [
    //             //       TextSpan(
    //             //           text: '\nClick here',
    //             //           style: Theme.of(context)
    //             //               .textTheme
    //             //               .displayMedium!
    //             //               .copyWith(
    //             //                 fontWeight: FontWeight.w700,
    //             //                 color: selectColor,
    //             //               )),
    //             //       TextSpan(text: ' to add a project')
    //             //     ]),
    //             //         ),
    //             //       )
    //           ],
    //         ),
    //       ),
    //       floatingActionButton: FloatingActionButton(
    //         onPressed: () {},
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(30.r)),
    //         child: Icon(
    //           Icons.add,
    //           color: Colors.white,
    //           size: 35,
    //         ),
    //         backgroundColor: selectColor,
    //       ),
    //     ));
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.perm_identity_outlined,
            color: textNotActive,
            size: IconSizes.largestIconSize,
          ),
          SizedBox(
            height: 10.h,
          ),
          BaseText(
            'Login to access this resource',
            fontWeight: FontWeight.w600,
            fontSize: TextSizes.textSize16SP,
          ),
          SizedBox(
            height: 20.h,
          ),
          AppButton(
            width: double.infinity,
            text: 'Login', backgroundColor: Colors.black, textColor: Colors.white, onPressed: (){

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ref.read(isModalShownProvider)){
                context.showSignUpModal(ref);
                ref.read(isModalShownProvider.notifier).state = true;
              }
            });
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },),
        ],
      ),
    );
  }
}
