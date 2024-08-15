import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nitoons/UI Actor/SignUp/sign_up.dart';
import 'package:nitoons/UI Actor/requests.dart';
import 'package:nitoons/UI%20Actor/home_page.dart';
import 'package:nitoons/UI%20Actor/nav_screens/message_page/message_page_vm.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/UI%20Actor/message_chat/messages_chat.dart';
import 'package:nitoons/data/socket_service.dart';
import 'package:nitoons/widgets/error_profile_picture.dart';
import '../../../components/app_searchfield.dart';
import '../../../constants/app_colors.dart';
import '../../../gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../UI Actor/roles/roles.dart';
import '../../UI Actor/roles/roles_vm.dart';
import '../../constants/sizes.dart';
import '../../constants/spacings.dart';
import '../../data/app_storage.dart';
import '../../widgets/base_text.dart';
import '../../widgets/main_button.dart';
import 'producer_conversation_vm.dart';
import 'producer_message_vm.dart';

class ProducerMessageView extends HookConsumerWidget {
  const ProducerMessageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ProducerMessageViewmodel(ref);
    final vm = ProducerConversationVm(ref);

    // final userConversations =
    //     ref.watch(ProducerMessageViewmodel.getConversationsProvider);
    // final allOpenRoles = ref.watch(RolesViewModel.getAllOpenRolesProvider);

    // ref.read(socketServiceInitializerProvider.future);
    Future<bool> _isAuthenticatedFuture = SecureStorageHelper.isAuthenticated();

    return FutureBuilder<bool>(
        future: _isAuthenticatedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Messages'),
                centerTitle: true,
              ),
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Messages'),
                centerTitle: true,
              ),
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
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
                    return Scaffold(
                        appBar: AppBar(
                          leadingWidth: 150.w,
                          // backgroundColor: Colors.white,
                          leading: Padding(
                            padding: EdgeInsets.only(left: 23.w),
                            child: Center(
                              child: Text(
                                'Messages',
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
                              child: GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Requests())),
                                  child: SvgPicture.asset(viewModel.isMessage
                                      ? Assets.svgs.indicatorbell
                                      : Assets.svgs.bell)),
                            )
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
                                      horizontal: 10
                                          .w), // Adjust as needed to make the line longer
                                ),
                                controller: viewModel.tabController,
                                tabs: [
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Friends',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        viewModel.isMessage
                                            ? SizedBox(width: 8.w)
                                            : SizedBox.shrink(),
                                        viewModel.isMessage
                                            ? Container(
                                                height: 18.h,
                                                decoration: BoxDecoration(
                                                    color: selectColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.r)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6.w,
                                                      vertical: 2.h),
                                                  child: Text(
                                                    '03',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Groups',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        viewModel.isMessage
                                            ? SizedBox(width: 8.w)
                                            : SizedBox.shrink(),
                                        viewModel.isMessage
                                            ? Container(
                                                height: 18.h,
                                                decoration: BoxDecoration(
                                                    color: selectColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.r)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6.w,
                                                      vertical: 2.h),
                                                  child: Text(
                                                    '03',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
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
                                    controller: viewModel.tabController,
                                    children: [
                                      buildMessageScreen(context, vm, ref),
                                      buildGroupMessageScreen(
                                          context, viewModel),
                                    ]),
                              )
                            ],
                          ),
                        ));
                  }
                });
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
GestureDetector buildGroupMessageScreen(
    BuildContext context, ProducerMessageViewmodel viewModel) {
  return GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
    child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 21.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AppSearchField(
                  controller: viewModel.searchController,
                ),
              ),
              viewModel.isMessage
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          SizedBox(height: 28.h),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => GroupChat())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                            radius: 28.r,
                                            backgroundColor: selectColor,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 26.r,
                                              child: Image.asset(
                                                  Assets.png.mikolo.path),
                                            )),
                                        SvgPicture.asset(Assets.svgs.group)
                                      ],
                                    ),
                                    SizedBox(
                                      width: 13.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mikolo',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              text: 'Niyi: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color: Color(0xffD2D2D2),
                                                      fontWeight:
                                                          FontWeight.w400),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'You guys were awesome...',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                )
                                              ]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '23 min',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffADAFBB)),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                          color: selectColor,
                                          borderRadius:
                                              BorderRadius.circular(1000.r)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 2.h),
                                        child: Center(
                                          child: Text(
                                            '1',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                          radius: 28.r,
                                          backgroundColor: selectColor,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 26.r,
                                            child: Image.asset(
                                                Assets.png.mikolo.path),
                                          )),
                                      SvgPicture.asset(Assets.svgs.group)
                                    ],
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'The House of Secrets',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: 'Niyi: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: Color(0xffD2D2D2),
                                                    fontWeight:
                                                        FontWeight.w400),
                                            children: [
                                              TextSpan(
                                                text: 'Typing...',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400),
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '23 min',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xffADAFBB)),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        color: selectColor,
                                        borderRadius:
                                            BorderRadius.circular(1000.r)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.w, vertical: 2.h),
                                      child: Center(
                                        child: Text(
                                          '1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                          radius: 28.r,
                                          backgroundColor: Color(0xffE8E6EA),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 26.r,
                                            child: Image.asset(
                                                Assets.png.mikolo.path),
                                          )),
                                      SvgPicture.asset(Assets.svgs.group)
                                    ],
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Funny Memes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: 'Lola: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: Color(0xffD2D2D2),
                                                    fontWeight:
                                                        FontWeight.w400),
                                            children: [
                                              TextSpan(
                                                text: 'Shared an image',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400),
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '23 min',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xffADAFBB)),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox.shrink()
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 70.h,
                        ),
                        SvgPicture.asset(Assets.svgs.empty),
                        SizedBox(
                          height: 34.h,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage())),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                                text: 'You currently have no messages.',
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
                        ),
                      ],
                    )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/newGroupPage");
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          backgroundColor: selectColor,
        )),
  );
}

Widget buildMessageScreen(
    BuildContext context, ProducerConversationVm viewModel, WidgetRef ref) {
  // final userConversations =
  //     ref.watch(ProducerMessageViewmodel.getConversationsProvider);
  final socketService = ref.watch(socketServiceProvider);
  final messageStream = ref.watch(messageStreamProvider);
  // viewModel.ref.read(socketServiceInitializerProvider.future);
  // final streamSocket = StreamSocket();
  return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 21.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AppSearchField(
                      controller: viewModel.searchFriendController),
                ),
                SizedBox(height: 28.h),
                messageStream.when(
                  data: (data) {
                    if (data.data.results!.isEmpty) {
                      return Center(child: Text('No messages found.'));
                    } else {
                      final conversations = data.data.results!;
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await viewModel.fetchConversations();
                          },
                          child: ListView.builder(
                            itemCount: conversations.length,
                            itemBuilder: (context, index) {
                              final converse = conversations[index];
                              final lastMessageAt =
                                  DateTime.parse(converse.lastMessageSentAt);
                              final formattedLastMessageAt =
                                  timeago.format(lastMessageAt);
                              final conversationId = converse.id;
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 24.w, right: 24.w, bottom: 12.h),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MessagesChat(
                                        fullName:
                                            '${converse.userProfile.firstName} ${converse.userProfile.lastName}',
                                        profilePicture:
                                            converse.userProfile.profilePicture,
                                        conversationId: conversationId,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 28.r,
                                            backgroundColor: selectColor,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 26.r,
                                              child: ClipOval(
                                                child: Image.network(
                                                  converse.userProfile
                                                      .profilePicture,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return ErrorProfilePicture();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 13.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${converse.userProfile.firstName} ${converse.userProfile.lastName}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                              Text(
                                                converse.lastMessage,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            formattedLastMessageAt,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xffADAFBB),
                                                ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Container(
                                            height: 20.h,
                                            width: 20.w,
                                            decoration: BoxDecoration(
                                              color: selectColor,
                                              borderRadius:
                                                  BorderRadius.circular(1000.r),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '1',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                  loading: () => Center(child: AppLoadingIndicator()),
                  error: (error, stack) => _buildErrorContent(context),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          backgroundColor: selectColor,
        ),
      ));
}

Widget _buildErrorContent(BuildContext context) {
  return Column(
    children: [
      SizedBox(height: 70.h),
      SvgPicture.asset(Assets.svgs.empty),
      SizedBox(height: 34.h),
      GestureDetector(
        onTap: () {},
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: 'You currently have no messages',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
            children: [
              TextSpan(
                text: '\nClick here',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: selectColor,
                    ),
              ),
              TextSpan(text: ' to create a group'),
            ],
          ),
        ),
      ),
    ],
  );
}
