import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../components/app_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/spacings.dart';
import '../../data/app_storage.dart';
import '../../gen/assets.gen.dart';
import '../../locator.dart';
import '../../models/get_multiple_roles_model.dart';
import '../producer monologue/producer_current_role_view.dart';
import 'add_monologues_to_role_update_vm.dart';
import 'add_monologues_to_role_vm.dart';

class ProducerAddMonologuesToRoleUpdate extends StatefulWidget {
  static String routeName = "/producerAddMonologuesToRoleUpdate";
  ProducerAddMonologuesToRoleUpdate({Key? key}) : super(key: key);

  @override
  State<ProducerAddMonologuesToRoleUpdate> createState() =>
      _ProducerAddMonologuesToRoleState();
}

class _ProducerAddMonologuesToRoleState
    extends State<ProducerAddMonologuesToRoleUpdate> {
  late Future<List<Datum>> _rolesFuture;

  @override
  void initState() {
    super.initState();
    final viewModel = locator<ProducerAddMonologuesToRoleUpdateViewModel>();
    _rolesFuture = viewModel.fetchUpdateMultipleRoles();
    viewModel.fetchUpdateMultipleRoles();
    _reloadRoles();
  }

  void _reloadRoles() {
    final viewModel = locator<ProducerAddMonologuesToRoleUpdateViewModel>();
    _rolesFuture = viewModel.fetchUpdateMultipleRoles();
  }

  @override
  Widget build(BuildContext context) {
    return MVVM<ProducerAddMonologuesToRoleUpdateViewModel>.builder(
      disposeVM: false,
      viewModel: locator<ProducerAddMonologuesToRoleUpdateViewModel>(),
      viewBuilder: (_, viewModel) => Scaffold(
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
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 24.w),
              child: Container(
                height: 29.h,
                width: 157.w,
                decoration: BoxDecoration(
                  color: selectColor.withOpacity(0.15),
                  border: Border.all(
                    color: selectColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(154.r),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'I want a single script',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400, color: selectColor),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Monologue',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Create monologues for all the roles in this project that you are casting for.',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 28.h),
                FutureBuilder<List<Datum>>(
                  future: _rolesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.transparent,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.svgs.emptybox),
                            SizedBox(height: 34.h),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'You currently have no roles created.',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final data = snapshot.data!;
                      return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = data[index];
                          final isActive = item.monologueScriptSet ?? false;
                          return GestureDetector(
                            onTap: () {
                              SharedPreferencesHelper
                                  .storeProducerProjectRoleId(
                                      item.id.toString());
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                    builder: (context) =>
                                        ProducerCurrentRolePage(
                                      roleName: item.roleName.toString(),
                                      roleId: item.id.toString(),
                                    ),
                                  ))
                                  .then((_) =>
                                      _reloadRoles()); // Reload roles after navigating back
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: Spacings.spacing10.h),
                              child: Container(
                                child: AllRolesTiles(
                                  title: item.roleName.toString(),
                                  isActive: isActive,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: Spacings.spacing100.h),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
          child: AppButton(
            width: double.infinity,
            onPressed: viewModel.allRolesActive
                ? () {
                    Navigator.pushReplacementNamed(
                        context, '/producerMonologueProjectDetailsPage');
                  }
                : null,
            text: 'Save and continue',
            backgroundColor:
                viewModel.allRolesActive ? Colors.black : Color(0xffEBECEF),
            textColor:
                viewModel.allRolesActive ? Colors.white : Color(0xff828491),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class AllRolesTiles extends StatelessWidget {
  final String title;
  final bool isActive;

  const AllRolesTiles({
    required this.title,
    this.isActive = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: isActive ? selectColor : Colors.grey),
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
                    ? SvgPicture.asset(
                        Assets.svgs.chevron,
                        height: 20.h,
                        width: 20.w,
                        colorFilter: ColorFilter.mode(
                          selectColor,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(
                        Assets.svgs.chevron,
                        height: 20.h,
                        width: 20.w,
                        colorFilter: ColorFilter.mode(
                          Color(0xffADAFBB),
                          BlendMode.srcIn,
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
