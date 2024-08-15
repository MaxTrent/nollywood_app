import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Producer/producer_nav_screens/producer_projects/producer_projects_vm.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/models/casting_project.dart';
import 'package:nitoons/models/producer_projectects.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../../UI Actor/SignUp/sign_up.dart';
import '../../../components/number_container.dart';
import '../../../constants/app_colors.dart';
import '../../../data/app_storage.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/base_text.dart';
import '../../../widgets/main_button.dart';
import '../../project_details/project_details.dart';

class ProducerProjects extends StatefulWidget {
  static String routeName = "/producerProjects";

  ProducerProjects({super.key});

  @override
  State<ProducerProjects> createState() => _ProducerProjectsState();
}

class _ProducerProjectsState extends State<ProducerProjects>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isProject = true;
  Future<bool> _isAuthenticatedFuture = SecureStorageHelper.isAuthenticated();
  final user =
      SharedPreferencesHelper.getUserProfession(); // Authentication future

  bool get isProject => _isProject;
  void toggleProject() {
    _isProject = !_isProject;
  }

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with a length of 2
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Dispose the TabController when the widget is disposed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _isAuthenticatedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!) {
            return _buildLoginScreen(
                context); // Show the login screen if not authenticated
          } else {
            return FutureBuilder<String?>(
                future: SharedPreferencesHelper.getUserProfession(),
                builder: (context, professionSnapshot) {
                  if (professionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (professionSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${professionSnapshot.error}'));
                  } else if (!professionSnapshot.hasData ||
                      professionSnapshot.data != 'Producer') {
                    return _buildProfessionLoginScreen(context);
                  } else {
                    // Continue with the main screen if the profession is "Producer"

                    return MVVM<ProducerProjectsViewModel>.builder(
                      disposeVM: false,
                      viewModel: locator<ProducerProjectsViewModel>(),
                      viewBuilder: (_, viewModel) => Scaffold(
                        appBar: AppBar(
                          leadingWidth: 150.w,
                          leading: Padding(
                            padding: EdgeInsets.only(left: 23.w),
                            child: Center(
                              child: Text(
                                'Projects',
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
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                      color: selectColor, width: 1.h),
                                  insets: EdgeInsets.symmetric(
                                      horizontal: 10.w ?? 100.w),
                                ),
                                controller: _tabController,
                                tabs: [
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'All',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        isProject
                                            ? SizedBox(width: 8.w)
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Casting',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        isProject
                                            ? SizedBox(width: 8.w)
                                            : SizedBox.shrink(),
                                        isProject
                                            ? NumberContainer(
                                                number: '20',
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Expanded(
                                child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      buildProducerProjectAllScreen(
                                          context, viewModel),
                                      buildProducerProjectsCastingScreen(
                                          context, viewModel),
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
              );
          }
        });
  }

  Widget _buildLoginScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BaseText(
          'Login',
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_identity_outlined,
              color: Colors.grey,
              size: 100.sp,
            ),
            SizedBox(height: 10.h),
            BaseText(
              'Login to access this resource',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: MainButton(
                text: 'Login',
                buttonColor: Colors.black,
                textColor: Colors.white,
                press: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildProfessionLoginScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BaseText(
          'Login',
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_identity_outlined,
              color: Colors.grey,
              size: 100.sp,
            ),
            SizedBox(height: 10.h),
            BaseText(
              'Login as a producer to access this resource',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: MainButton(
                text: 'Login',
                buttonColor: Colors.black,
                textColor: Colors.white,
                press: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProducerProjectAllScreen(
      BuildContext context, ProducerProjectsViewModel viewModel) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: FutureBuilder<List<Data>>(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/producerProjectPage');
                        },
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: 'You currently have no Projects.',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: '\nClick here',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: selectColor,
                                        )),
                                TextSpan(text: ' to add a project')
                              ]),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                final projects = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.65),
                  itemCount: projects.length,
                  itemBuilder: (BuildContext context, int index) {
                    final project = projects[index];
                    return GestureDetector(
                      onTap: () {
                        SharedPreferencesHelper.storeProducerProjectId(
                            project.sId.toString());
                        // ProducerProjectsViewModel.storeProducerProjectId(
                        //     project.sId.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetails(
                              projectName: project.projectName.toString(),
                              projectId: project.sId.toString(),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              project.thumbnail.toString(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 192.h,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            project.projectName!.length > 25
                                ? project.projectName!.substring(0, 23) + '...'
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
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/producerProjectPage');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          backgroundColor: selectColor,
        ),
      ),
    );
  }

  Widget buildProducerProjectsCastingScreen(
      BuildContext context, ProducerProjectsViewModel viewModel) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          body: Padding(
            padding:EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: FutureBuilder<List<Datum>>(
              future: viewModel.fetchAllProducerCastingProjects(),
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
                              text: 'No project is being casted',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w400),
                              children: [
                              ]),
                        )
                      ],
                    ),
                  );
                } else {
                  final projects = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.65),
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      final project = projects[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              project.thumbnail.toString(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 192.h,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            project.projectName!.length > 25
                                ? project.projectName!.substring(0, 23) + '...'
                                : project.projectName!.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ));
  }
}
