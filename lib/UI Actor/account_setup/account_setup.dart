import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/constants/spacings.dart';
import 'package:nitoons/locator.dart';
import 'package:nitoons/models/account_setup.dart';
import 'package:pmvvm/pmvvm.dart';
import '../../components/app_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/sizes.dart';
import '../../data/app_storage.dart';
import '../../widgets/base_text.dart';
import '../../widgets/main_button.dart';
import '../SignUp/sign_up.dart';
import 'account_setup_vm.dart';

class AccountSetup extends StatefulWidget {
  static String routeName = "/account_setup";
  const AccountSetup({Key? key}) : super(key: key);

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  late Future<AccountSetupModel> _future;
 
  Future<bool> _isAuthenticatedFuture =
      SecureStorageHelper.isAuthenticated(); // Authentication future

  @override
  void initState() {
    super.initState();
    locator<AccountSetupViewModel>().checkProfileCompletion();
    _future = locator<AccountSetupViewModel>().fetchApiResponse();
    
    
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = locator<AccountSetupViewModel>().fetchApiResponse();
     
    });
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
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: BaseText(
                  'Login',
                  color: black,
                  fontSize: TextSizes.textSize16SP,
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Spacings.spacing70.w),
                      child: MainButton(
                        text: 'Login',
                        buttonColor: black,
                        textColor: white,
                        press: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                            (route) => false,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ); // Show the login screen if not authenticated
          }

          return MVVM<AccountSetupViewModel>.builder(
            disposeVM: false,
            viewModel: locator<AccountSetupViewModel>(),
            viewBuilder: (context, vm) {
              return Scaffold(
                body: RefreshIndicator.adaptive(
                  backgroundColor: white,
                  color: black,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  onRefresh: _refresh,
                  child: FutureBuilder<AccountSetupModel>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(black),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final data = snapshot.data!.data;

                        // Widget controlled by profile completion status
                        return SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Finish account setup',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Let\'s get you Onboard!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff757575),
                                        ),
                                  ),
                                  SizedBox(height: 28.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Step ${vm.activeCount} of ${vm.accountList.length}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 16.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          vm.accountList.length,
                                          (index) {
                                            double containerWidth =
                                                300.0 / vm.accountList.length;
                                            return Row(
                                              children: [
                                                Container(
                                                  height: 2.h,
                                                  width: containerWidth,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        index < vm.activeCount
                                                            ? Colors.black
                                                            : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(width: 3.w),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 28.h),
                                      ListView.builder(
                                        itemCount: vm.accountList.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final item = vm.accountList[index];
                                          final isActive = data[
                                                  item['indicator']!
                                                      .toLowerCase()
                                                      .replaceAll(' ', '_')] ??
                                              false;
                                          return GestureDetector(
                                            onTap: () {
                                              final route = item['route'];
                                              if (route != null) {
                                                Navigator.pushNamed(
                                                    context, route);
                                              } else {
                                                return null;
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Spacings.spacing10.h),
                                              child: AccountSetupTiles(
                                                title: item['title']!,
                                                subtitle: item['subtitle']!,
                                                isActive: isActive,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 28.h),
                                      Center(
                                        child: Container(
                                          height: 35.h,
                                          width: 195.w,
                                          decoration: BoxDecoration(
                                            color: vm.activeCount ==
                                                    vm.accountList.length
                                                ? Color(0xffB8FACD)
                                                : selectColor.withOpacity(0.12),
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              vm.activeCount ==
                                                      vm.accountList.length
                                                  ? 'Yay! You’re all good to go👏'
                                                  : 'You’re almost there!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    fontSize: 12.sp,
                                                    color: vm.activeCount ==
                                                            vm.accountList
                                                                .length
                                                        ? black
                                                        : selectColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 25.h),
                                      Center(
                                        child: AppButton(
                                          width: double.infinity,
                                          text: vm.activeCount ==
                                                  vm.accountList.length
                                              ? 'Take me home'
                                              : 'Complete later',
                                          backgroundColor: vm.activeCount ==
                                                  vm.accountList.length
                                              ? Colors.black
                                              : Colors.white,
                                          onPressed: vm.activeCount ==
                                                  vm.accountList.length
                                              ? () {
                                                  Navigator.pop(context);
                                                }
                                              : null,
                                          textColor: vm.activeCount ==
                                                  vm.accountList.length
                                              ? Colors.white
                                              : Colors.black,
                                          borderColor: vm.activeCount ==
                                                  vm.accountList.length
                                              ? Colors.transparent
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 25.h),
                                      if (vm.isComplete)
                                        Center(
                                          child: Text(
                                            'Profile is complete!',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                  fontSize: 12.sp,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(child: Text('No data found'));
                      }
                    },
                  ),
                ),
              );
            },
          );
        });
  }
}

class AccountSetupTiles extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isActive;

  const AccountSetupTiles({
    required this.title,
    required this.subtitle,
    this.isActive = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: isActive ? Colors.black : Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                isActive
                    ? Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 8),
                      )
                    : Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
