import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/nav_screens/feed_page/feed_page.dart';
import 'package:nitoons/UI Actor/profile_screen.dart';
import '../UI Producer/producer_message_page/producer_message_view.dart';
import '../UI Producer/producer_nav_screens/producer_feedpage/producer_feedpage.dart';
import '../UI Producer/producer_nav_screens/producer_projects/producer_projects.dart';
import '../UI Producer/producer_profilescreen/producer_profilescreen.dart';
import '../constants/app_colors.dart';
import '../constants/images.dart';
import '../constants/sizes.dart';
import '../constants/spacings.dart';
import '../data/app_storage.dart';
import '../gen/assets.gen.dart';
import '../widgets/base_text.dart';
import '../widgets/main_button.dart';
import 'SignUp/login_page.dart';
import 'SignUp/sign_up.dart';
import 'SignUp/signup_modal_sheet.dart';
import 'nav_screens/message_page/message_page.dart';
import 'roles/roles.dart';
import 'post/upload_post.dart';
import 'record_monologue/record_monologue.dart';

final isModalShownProvider = StateProvider((ref) => false);

extension ModalExtensions on BuildContext {
  void showSignUpModal(WidgetRef ref) {
    print('sign up sheet');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: this,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 772.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24.w),
              child: SignUpPage(),
            ),
          );
        },
      ).then((value) {
        ref.read(isModalShownProvider.notifier).state = false;
        print('sign up sheet dismissed');
      });
    });
  }
}

class HomePage extends StatefulWidget {
  static String routeName = "/home_page";

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String? accountType;
  List<Widget> _actorPages = [
    FeedPage(),
    Roles(),
    RecordMonologue(),
    MessagePage(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    // if (mounted) {
    setState(() {});
    // }
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: _actorPages,
        ),
      ),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight,
        color: Colors.white,
        child: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.fromLTRB(
                0.0, 0.0, 0.0, kBottomNavigationBarHeight - 0.5.h),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.h),
          ),
          controller: tabController,
          tabs: [
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.home,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 0 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            ),
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.messagecircle,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 1 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            ),
            Tab(
              icon: SvgPicture.asset(Assets.svgs.create),
            ),
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.message,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 3 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            ),
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.profile,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 4 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            )
          ],
        ),
      ),
    );
  }
}

class ProducerHomePage extends StatefulWidget {
  static String routeName = "/producer_home_page";

  ProducerHomePage({super.key});

  @override
  State<ProducerHomePage> createState() => _ProducerHomePageState();
}

class _ProducerHomePageState extends State<ProducerHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool _isModalShown = false;

  List<Widget> _producerpages = [
    ProducerFeedPage(),
    ProducerProjects(),
    ProducerProfileScreen(),
    // Scaffold(),
    ProducerMessageView(),
    ProducerProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() async {
    if (mounted) {
      if (tabController.index > 0) {
        bool isAuthenticated = await SecureStorageHelper.isAuthenticated();
        if (!isAuthenticated && !_isModalShown) {
          _isModalShown = true; // Set the flag to true

          LoginBottomSheetMethod();

          // showCustomModalBottomSheet(context);
          // Prevent updating the tab if not authenticated
        }
      }
      setState(() {});
    }
  }

  void LoginBottomSheetMethod() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height *
              0.9, // Set height to 90% of screen height
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: Spacings.spacing50.h),
                    Padding(
                      padding: EdgeInsets.fromLTRB(136.w, 0, 117.w, 7.h),
                      child: SvgPicture.asset(
                        alignment: Alignment.center,
                        Svgs.appIcon,
                        width: Spacings.spacing120.w,
                        height: Spacings.spacing76,
                        color: black,
                      ),
                    ),
                    BaseText(
                      'NOLLYWOOD ACTOR',
                      fontWeight: FontWeight.w400,
                      fontSize: TextSizes.textSize14SP,
                      color: black,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Spacings.spacing52.h),
                    BaseText(
                      'Sign up to continue',
                      fontWeight: FontWeight.w400,
                      fontSize: TextSizes.textSize18SP,
                      color: LightTextColor,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Spacings.spacing30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Spacings.spacing24.w),
                      child: MainButton(
                        text: 'Continue with email',
                        buttonColor: black,
                        textColor: white,
                        press: () {
                          Navigator.pushNamed(
                              context, '/emailAddressSignUp');
                        },
                      ),
                    ),
                    SizedBox(height: Spacings.spacing16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Spacings.spacing24.w),
                      child: MainButton(
                        text: 'Use phone number',
                        buttonColor: Colors.transparent,
                        textColor: black,
                        borderColor: black,
                        press: () {
                          Navigator.pushNamed(
                              context, '/phoneNumberPage');
                        },
                      ),
                    ),
                    SizedBox(height: Spacings.spacing32.h),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Divider(color: dividerColor),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 20.w),
                            child: BaseText(
                              'or sign up with',
                              color: LightTextColor,
                              fontSize: TextSizes.textSize12SP,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Divider(color: dividerColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Spacings.spacing26.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Spacings.spacing10.h,
                              horizontal: Spacings.spacing10.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(
                                Spacings.spacing8.sp),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/loginPhoneNumberPage');
                            },
                            child: SvgPicture.asset(
                              Svgs.facebookIcon,
                              width: IconSizes.mainIconSize,
                              height: IconSizes.mainIconSize,
                            ),
                          ),
                        ),
                        SizedBox(width: Spacings.spacing20.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/loginEmailAddressPage');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Spacings.spacing10.h,
                                horizontal: Spacings.spacing10.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(
                                  Spacings.spacing8.sp),
                            ),
                            child: SvgPicture.asset(
                              Svgs.googleIcon,
                              width: IconSizes.mainIconSize,
                              height: IconSizes.mainIconSize,
                            ),
                          ),
                        ),
                        SizedBox(width: Spacings.spacing20.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Spacings.spacing10.h,
                              horizontal: Spacings.spacing10.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(
                                Spacings.spacing8.sp),
                          ),
                          child: SvgPicture.asset(
                            Svgs.apple,
                            width: IconSizes.mainIconSize,
                            height: IconSizes.mainIconSize,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacings.spacing78.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                          'Already have an account?',
                          fontSize: TextSizes.textSize18SP,
                          fontWeight: FontWeight.w400,
                          color: LightTextColor,
                        ),
                        SizedBox(width: Spacings.spacing4.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/loginEmailAddressPage');
                          },
                          child: BaseText(
                            ' Log in',
                            fontSize: TextSizes.textSize18SP,
                            color: signInColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacings.spacing60.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                          'Terms of use',
                          fontSize: TextSizes.textSize18SP,
                          fontWeight: FontWeight.w400,
                          color: LightTextColor,
                        ),
                        SizedBox(width: Spacings.spacing30.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/privacyPolicy');
                          },
                          child: BaseText(
                            'Privacy Policy',
                            fontSize: TextSizes.textSize18SP,
                            color: LightTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacings.spacing20.h),
                  ],
                ),
              ),
              Positioned(
                right: 16.0,
                top: 16.0,
                child: GestureDetector(
                  onTap: () {
                    // Close the bottom sheet
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, size: 30.0),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      _isModalShown = false; // Reset the flag when modal is closed
    });
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: _producerpages,
        ),
      ),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight,
        color: Colors.transparent,
        child: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.fromLTRB(
                0.0, 0.0, 0.0, kBottomNavigationBarHeight - 0.5.h),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.h),
          ),
          controller: tabController,
          tabs: [
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.home,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 0 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            ),
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.messagecircle,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 1 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            ),
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(
                    Assets.svgs.create,
                  )),
            ),
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.message,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 3 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            ),
            Tab(
              icon: SizedBox(
                  width: 53.w,
                  child: SvgPicture.asset(Assets.svgs.profile,
                      colorFilter: ColorFilter.mode(
                          tabController.index == 4 ? Colors.black : Colors.grey,
                          BlendMode.srcIn))),
            )
          ],
        ),
      ),
    );
  }
}
