import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/data/socket_service.dart';
import 'package:nitoons/widgets/error_profile_picture.dart';
import '../../../components/app_searchfield.dart';
import '../../../constants/app_colors.dart';
import '../../../gen/assets.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../roles/roles.dart';
import '../../roles/roles_vm.dart';

class MessagePage extends HookConsumerWidget {
  MessagePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = MessagePageViewModel(ref);
    final userConversations =
        ref.watch(MessagePageViewModel.getConversationsProvider);
    final allOpenRoles = ref.watch(RolesViewModel.getAllOpenRolesProvider);

    ref.read(socketServiceInitializerProvider.future);
    // ref.refresh(RolesViewModel.getAllOpenRolesProvider);
    // viewModel.fetchConversations();

    return allOpenRoles.when(data: (openRoles) {
      if (openRoles.error && openRoles.data == null) {
        if (openRoles.code == 400) {

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ref.read(isModalShownProvider)){
              context.showSignUpModal(ref);
              ref.read(isModalShownProvider.notifier).state = true;
            }
          });
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => SignUpPage()));
          // });
          return Scaffold(
            body: Center(
              child: LoginButton(),
            ),
          );
        }}
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
                        MaterialPageRoute(builder: (context) => Requests())),
                    child: SvgPicture.asset(viewModel.isMessage
                        ? Assets.svgs.indicatorbell
                        : Assets.svgs.bell)),
              )
            ],
          ),
          body: FutureBuilder(
            future: SecureStorageHelper.getUserId(),
            builder:(context, userIdSnapshot)=> SafeArea(
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
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: selectColor, width: 1.h),
                      insets: EdgeInsets.symmetric(
                          horizontal:
                          10.w), // Adjust as needed to make the line longer
                    ),
                    controller: viewModel.tabController,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            viewModel.isMessage
                                ? SizedBox(width: 8.w)
                                : SizedBox.shrink(),
                            viewModel.isMessage
                                ? Container(
                              height: 18.h,
                              decoration: BoxDecoration(
                                  color: selectColor,
                                  borderRadius: BorderRadius.circular(100.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 2.h),
                                child: Text(
                                  '03',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                            )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Groups',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            viewModel.isMessage
                                ? SizedBox(width: 8.w)
                                : SizedBox.shrink(),
                            viewModel.isMessage
                                ? Container(
                              height: 18.h,
                              decoration: BoxDecoration(
                                  color: selectColor,
                                  borderRadius: BorderRadius.circular(100.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 2.h),
                                child: Text(
                                  '03',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
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
                    child:
                    TabBarView(controller: viewModel.tabController, children: [
                      buildMessageScreen(context, viewModel, ref, userIdSnapshot.data),
                      buildGroupMessageScreen(context, viewModel),
                    ]),
                  )
                ],
              ),
            ),
          )
        );
    }, error: (error, _){
      print(error);
      return Scaffold(
        body: Center(child: Text('An Error Occured' + error.toString())),
      );
    }, loading: (){
      return Center(child: AppLoadingIndicator());
    });

  }


  }

  GestureDetector buildGroupMessageScreen(
      BuildContext context, MessagePageViewModel viewModel) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                                text: 'Niyi: ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color:
                                                            Color(0xffD2D2D2),
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
                                                                FontWeight
                                                                    .w400),
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                    TextSpan(text: ' to send a message')
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
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
      BuildContext context, MessagePageViewModel viewModel, WidgetRef ref, String? userId) {
    // final userConversations =
    //     ref.watch(MessagePageViewModel.getConversationsProvider);
    final socketService = ref.watch(socketServiceProvider);
    final streamSocket = StreamSocket();
    final firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    final firestore = FirebaseFirestore.instance;
    final userConversations = firestore.collection('conversations')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageSentAt', descending: true)
        .snapshots();

    print('userId is $userId');


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
                SizedBox(height: 28.h),

                StreamBuilder(
                    stream: userConversations,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: AppLoadingIndicator());
                      } else if (snapshot.hasError) {
                        return Column(
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
                                    text: 'You currently have no messages',
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
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No messages found.'));
                      } else {
                        // if (snapshot.data!.code == 400) {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => SignUpPage()));
                        // }
                        final conversations = snapshot.data!.docs;
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await viewModel.fetchConversations();
                            },
                            child: ListView.builder(
                                itemCount: conversations.length,
                                itemBuilder: (context, index) {
                                  final conversation = conversations[index].data() as Map<String, dynamic>;
                                  final lastMessageAt = (conversation['lastMessageSentAt'] as String);
                                  // final formattedLastMessageAt = timeago.format(lastMessageAt);
                                  final participants = conversation['participants'] as List<dynamic>;
                                  final otherParticipantId = participants.firstWhere((id) => id != userId);
                                  final conversationId = conversations[index].id;

                                  // final lastMessageAt = DateTime.parse(
                                  //     conversations[index].lastMessageSentAt);
                                  //
                                  // final formattedLastMessageAt =
                                  //     timeago.format(lastMessageAt);
                                  //
                                  // final conversationId =
                                  //     conversations[index].id;

                                  // print(formattedLastMessageAt);

                                  return FutureBuilder(future: firestore.collection('users').doc(otherParticipantId).get(), builder: (context, snapshot){
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: AppLoadingIndicator());
                                    } else if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                                      return ErrorProfilePicture();
                                    } else{
                                      final otherParticipant = snapshot.data!.data() as Map<String, dynamic>;
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 24.w, right: 24.w, bottom: 12.h),
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessagesChat(
                                                        fullName:
                                                        '${otherParticipant['firstName']} ${otherParticipant['lastName']}',
                                                        profilePicture:
                                                        otherParticipant['profilePicUrl'],
                                                        conversationId:
                                                        conversationId,
                                                      ))),
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
                                                        backgroundColor:
                                                        Colors.white,
                                                        radius: 26.r,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            otherParticipant['profilePicUrl'],
                                                            fit: BoxFit.cover,
                                                            // Assets.png.profilepic.path

                                                            errorBuilder: (context,
                                                                error, stackTrace) {
                                                              return ErrorProfilePicture();
                                                            },
                                                          ),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 13.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        // 'Adesua Etomi',
                                                        '${otherParticipant['firstName']} ${otherParticipant['lastName']}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall!
                                                            .copyWith(
                                                            fontWeight:
                                                            FontWeight
                                                                .w700),
                                                      ),
                                                      Text(
                                                        // 'Thank you so much 😍',
                                                        conversation['lastMessage'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall!
                                                            .copyWith(
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
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
                                                    // '23 min',
                                                    lastMessageAt,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        color:
                                                        Color(0xffADAFBB)),
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
                                                        BorderRadius.circular(
                                                            1000.r)),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 6.w,
                                                          vertical: 2.h),
                                                      child: Center(
                                                        child: Text(
                                                          '1',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .displayMedium!
                                                              .copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              color:
                                                              Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );

                                    }
                                  });

                                  // return Padding(
                                  //   padding: EdgeInsets.only(
                                  //       left: 24.w, right: 24.w, bottom: 12.h),
                                  //   child: GestureDetector(
                                  //     onTap: () => Navigator.of(context).push(
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 MessagesChat(
                                  //                   fullName:
                                  //                       '${conversations[index].userProfile.firstName} ${conversations[index].userProfile.lastName}',
                                  //                   profilePicture:
                                  //                       conversations[index]
                                  //                           .userProfile
                                  //                           .profilePicture,
                                  //                   conversationId:
                                  //                       conversationId,
                                  //                 ))),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             CircleAvatar(
                                  //                 radius: 28.r,
                                  //                 backgroundColor: selectColor,
                                  //                 child: CircleAvatar(
                                  //                   backgroundColor:
                                  //                       Colors.white,
                                  //                   radius: 26.r,
                                  //                   child: ClipOval(
                                  //                     child: Image.network(
                                  //                       fit: BoxFit.cover,
                                  //                       // Assets.png.profilepic.path
                                  //                       conversations[index]
                                  //                           .userProfile
                                  //                           .profilePicture,
                                  //                       errorBuilder: (context,
                                  //                           error, stackTrace) {
                                  //                         return ErrorProfilePicture();
                                  //                       },
                                  //                     ),
                                  //                   ),
                                  //                 )),
                                  //             SizedBox(
                                  //               width: 13.w,
                                  //             ),
                                  //             Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   // 'Adesua Etomi',
                                  //                   '${conversations[index].userProfile.firstName} ${conversations[index].userProfile.lastName}',
                                  //                   style: Theme.of(context)
                                  //                       .textTheme
                                  //                       .displaySmall!
                                  //                       .copyWith(
                                  //                           fontWeight:
                                  //                               FontWeight
                                  //                                   .w700),
                                  //                 ),
                                  //                 Text(
                                  //                   // 'Thank you so much 😍',
                                  //                   conversations[index]
                                  //                       .lastMessage,
                                  //                   style: Theme.of(context)
                                  //                       .textTheme
                                  //                       .displaySmall!
                                  //                       .copyWith(
                                  //                           fontWeight:
                                  //                               FontWeight
                                  //                                   .w400),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.end,
                                  //           children: [
                                  //             Text(
                                  //               // '23 min',
                                  //               formattedLastMessageAt,
                                  //               style: Theme.of(context)
                                  //                   .textTheme
                                  //                   .displaySmall!
                                  //                   .copyWith(
                                  //                       fontSize: 12.sp,
                                  //                       fontWeight:
                                  //                           FontWeight.w700,
                                  //                       color:
                                  //                           Color(0xffADAFBB)),
                                  //             ),
                                  //             SizedBox(
                                  //               height: 5.h,
                                  //             ),
                                  //             Container(
                                  //               height: 20.h,
                                  //               width: 20.w,
                                  //               decoration: BoxDecoration(
                                  //                   color: selectColor,
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           1000.r)),
                                  //               child: Padding(
                                  //                 padding: EdgeInsets.symmetric(
                                  //                     horizontal: 6.w,
                                  //                     vertical: 2.h),
                                  //                 child: Center(
                                  //                   child: Text(
                                  //                     '1',
                                  //                     style: Theme.of(context)
                                  //                         .textTheme
                                  //                         .displayMedium!
                                  //                         .copyWith(
                                  //                             fontSize: 10.sp,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w400,
                                  //                             color:
                                  //                                 Colors.white),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             )
                                  //           ],
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // );
                                  //
                                }),
                          ),
                        );
                      }
                    }
                  ),

                // userConversations.when(data: (conversations) {
                //   return Expanded(
                //     child: ListView.builder(
                //         itemCount: conversations.data.results.length,
                //         itemBuilder: (context, index) {
                //           final lastMessageAt = DateTime.parse(conversations
                //               .data.results[index].lastMessageSentAt);

                //           final formattedLastMessageAt =
                //               timeago.format(lastMessageAt);

                //           final conversationId =
                //               conversations.data.results[index].id;

                //           print(formattedLastMessageAt);

                //           return Padding(
                //             padding: EdgeInsets.only(
                //                 left: 24.w, right: 24.w, bottom: 12.h),
                //             child: GestureDetector(
                //               onTap: () {
                //                 Navigator.of(context).push(MaterialPageRoute(
                //                     builder: (context) => MessagesChat(
                //                           fullName:
                //                               '${conversations.data.results[index].userProfile.firstName} ${conversations.data.results[index].userProfile.lastName}',
                //                           profilePicture: conversations
                //                               .data
                //                               .results[index]
                //                               .userProfile
                //                               .profilePicture,
                //                           conversationId: conversationId,
                //                         )));
                //               },
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Row(
                //                     children: [
                //                       CircleAvatar(
                //                           radius: 28.r,
                //                           backgroundColor: selectColor,
                //                           child: CircleAvatar(
                //                             backgroundColor: Colors.white,
                //                             radius: 26.r,
                //                             child: ClipOval(
                //                               child: Image.network(
                //                                 fit: BoxFit.cover,
                //                                 // Assets.png.profilepic.path
                //                                 conversations
                //                                     .data
                //                                     .results[index]
                //                                     .userProfile
                //                                     .profilePicture,
                //                                 errorBuilder: (context, error,
                //                                     stackTrace) {
                //                                   return ErrorProfilePicture();
                //                                 },
                //                               ),
                //                             ),
                //                           )),
                //                       SizedBox(
                //                         width: 13.w,
                //                       ),
                //                       Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Text(
                //                             // 'Adesua Etomi',
                //                             '${conversations.data.results[index].userProfile.firstName} ${conversations.data.results[index].userProfile.lastName}',
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .displaySmall!
                //                                 .copyWith(
                //                                     fontWeight:
                //                                         FontWeight.w700),
                //                           ),
                //                           Text(
                //                             // 'Thank you so much 😍',
                //                             conversations.data.results[index]
                //                                 .lastMessage,
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .displaySmall!
                //                                 .copyWith(
                //                                     fontWeight:
                //                                         FontWeight.w400),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: [
                //                       Text(
                //                         // '23 min',
                //                         formattedLastMessageAt,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .displaySmall!
                //                             .copyWith(
                //                                 fontSize: 12.sp,
                //                                 fontWeight: FontWeight.w700,
                //                                 color: Color(0xffADAFBB)),
                //                       ),
                //                       SizedBox(
                //                         height: 5.h,
                //                       ),
                //                       Container(
                //                         height: 20.h,
                //                         width: 20.w,
                //                         decoration: BoxDecoration(
                //                             color: selectColor,
                //                             borderRadius:
                //                                 BorderRadius.circular(1000.r)),
                //                         child: Padding(
                //                           padding: EdgeInsets.symmetric(
                //                               horizontal: 6.w, vertical: 2.h),
                //                           child: Center(
                //                             child: Text(
                //                               '1',
                //                               style: Theme.of(context)
                //                                   .textTheme
                //                                   .displayMedium!
                //                                   .copyWith(
                //                                       fontSize: 10.sp,
                //                                       fontWeight:
                //                                           FontWeight.w400,
                //                                       color: Colors.white),
                //                             ),
                //                           ),
                //                         ),
                //                       )
                //                     ],
                //                   )
                //                 ],
                //               ),
                //             ),
                //           );
                //         }),
                //   );
                // }, error: (error, _) {
                //   return Column(
                //     children: [
                //       SizedBox(
                //         height: 70.h,
                //       ),
                //       SvgPicture.asset(Assets.svgs.empty),
                //       SizedBox(
                //         height: 34.h,
                //       ),
                //       GestureDetector(
                //         onTap: () => Navigator.of(context).push(
                //             MaterialPageRoute(
                //                 builder: (context) => SignUpPage())),
                //         child: Text.rich(
                //           textAlign: TextAlign.center,
                //           TextSpan(
                //             text: 'Error Loading Messages: $error',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .displayMedium!
                //                 .copyWith(fontWeight: FontWeight.w400),
                //             // children: [
                //             //   TextSpan(
                //             //       text: '\nClick here',
                //             //       style: Theme.of(context)
                //             //           .textTheme
                //             //           .displayMedium!
                //             //           .copyWith(
                //             //             fontWeight: FontWeight.w700,
                //             //             color: selectColor,
                //             //           )),
                //             //   TextSpan(text: ' to add a project')
                //             // ]
                //           ),
                //         ),
                //       ),
                //     ],
                //   );
                // }, loading: () {
                //   return Expanded(child: Center(child: AppLoadingIndicator()));
                // })

                // viewModel.isMessage
                //     ? Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 24.w),
                //         child: Column(
                //           children: [
                //             SizedBox(height: 28.h),
                //             GestureDetector(
                //               onTap: () => Navigator.of(context).push(
                //                   MaterialPageRoute(
                //                       builder: (context) => MessagesChat())),
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Row(
                //                     children: [
                //                       CircleAvatar(
                //                           radius: 28.r,
                //                           backgroundColor: selectColor,
                //                           child: CircleAvatar(
                //                             backgroundColor: Colors.white,
                //                             radius: 26.r,
                //                             child: Image.asset(
                //                                 Assets.png.profilepic.path),
                //                           )),
                //                       SizedBox(
                //                         width: 13.w,
                //                       ),
                //                       Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Text(
                //                             'Adesua Etomi',
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .displaySmall!
                //                                 .copyWith(
                //                                     fontWeight:
                //                                         FontWeight.w700),
                //                           ),
                //                           Text(
                //                             'Thank you so much 😍',
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .displaySmall!
                //                                 .copyWith(
                //                                     fontWeight:
                //                                         FontWeight.w400),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: [
                //                       Text(
                //                         '23 min',
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .displaySmall!
                //                             .copyWith(
                //                                 fontSize: 12.sp,
                //                                 fontWeight: FontWeight.w700,
                //                                 color: Color(0xffADAFBB)),
                //                       ),
                //                       SizedBox(
                //                         height: 5.h,
                //                       ),
                //                       Container(
                //                         height: 20.h,
                //                         width: 20.w,
                //                         decoration: BoxDecoration(
                //                             color: selectColor,
                //                             borderRadius:
                //                                 BorderRadius.circular(1000.r)),
                //                         child: Padding(
                //                           padding: EdgeInsets.symmetric(
                //                               horizontal: 6.w, vertical: 2.h),
                //                           child: Center(
                //                             child: Text(
                //                               '1',
                //                               style: Theme.of(context)
                //                                   .textTheme
                //                                   .displayMedium!
                //                                   .copyWith(
                //                                       fontSize: 10.sp,
                //                                       fontWeight:
                //                                           FontWeight.w400,
                //                                       color: Colors.white),
                //                             ),
                //                           ),
                //                         ),
                //                       )
                //                     ],
                //                   )
                //                 ],
                //               ),
                //             ),
                //             SizedBox(height: 12.h),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Row(
                //                   children: [
                //                     CircleAvatar(
                //                         radius: 28.r,
                //                         backgroundColor: selectColor,
                //                         child: CircleAvatar(
                //                           backgroundColor: Colors.white,
                //                           radius: 26.r,
                //                           child: Image.asset(
                //                               Assets.png.profilepic.path),
                //                         )),
                //                     SizedBox(
                //                       width: 13.w,
                //                     ),
                //                     Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           'Adesua Etomi',
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .displaySmall!
                //                               .copyWith(
                //                                   fontWeight: FontWeight.w700),
                //                         ),
                //                         Text(
                //                           'Typing...',
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .displaySmall!
                //                               .copyWith(
                //                                   fontWeight: FontWeight.w400,
                //                                   color: Color(0xffADAFBB)),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.end,
                //                   children: [
                //                     Text(
                //                       '23 min',
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .displaySmall!
                //                           .copyWith(
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w700,
                //                               color: Color(0xffADAFBB)),
                //                     ),
                //                     SizedBox(
                //                       height: 5.h,
                //                     ),
                //                     Container(
                //                       height: 20.h,
                //                       width: 20.w,
                //                       decoration: BoxDecoration(
                //                           color: selectColor,
                //                           borderRadius:
                //                               BorderRadius.circular(1000.r)),
                //                       child: Padding(
                //                         padding: EdgeInsets.symmetric(
                //                             horizontal: 6.w, vertical: 2.h),
                //                         child: Center(
                //                           child: Text(
                //                             '1',
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .displayMedium!
                //                                 .copyWith(
                //                                     fontSize: 10.sp,
                //                                     fontWeight: FontWeight.w400,
                //                                     color: Colors.white),
                //                           ),
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 )
                //               ],
                //             ),
                //             SizedBox(height: 12.h),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Row(
                //                   children: [
                //                     CircleAvatar(
                //                         radius: 28.r,
                //                         backgroundColor: Color(0xffE8E6EA),
                //                         child: CircleAvatar(
                //                           backgroundColor: Colors.white,
                //                           radius: 26.r,
                //                           child: Image.asset(
                //                               Assets.png.profilepic.path),
                //                         )),
                //                     SizedBox(
                //                       width: 13.w,
                //                     ),
                //                     Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           'Adesua Etomi',
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .displaySmall!
                //                               .copyWith(
                //                                   fontWeight: FontWeight.w700),
                //                         ),
                //                         Text(
                //                           'Ok, see you then.',
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .displaySmall!
                //                               .copyWith(
                //                                   fontWeight: FontWeight.w400),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.end,
                //                   children: [
                //                     Text(
                //                       '23 min',
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .displaySmall!
                //                           .copyWith(
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w700,
                //                               color: Color(0xffADAFBB)),
                //                     ),
                //                     SizedBox(
                //                       height: 5.h,
                //                     ),
                //                     SizedBox.shrink()
                //                   ],
                //                 )
                //               ],
                //             ),
                //           ],
                //         ),
                //       )
                //     : Column(
                //         children: [
                //           SizedBox(
                //             height: 70.h,
                //           ),
                //           SvgPicture.asset(Assets.svgs.empty),
                //           SizedBox(
                //             height: 34.h,
                //           ),
                //           GestureDetector(
                //             onTap: () => Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                     builder: (context) => SignUpPage())),
                //             child: Text.rich(
                //               textAlign: TextAlign.center,
                //               TextSpan(
                //                   text: 'You currently have no projects.',
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .displayMedium!
                //                       .copyWith(fontWeight: FontWeight.w400),
                //                   children: [
                //                     TextSpan(
                //                         text: '\nClick here',
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .displayMedium!
                //                             .copyWith(
                //                               fontWeight: FontWeight.w700,
                //                               color: selectColor,
                //                             )),
                //                     TextSpan(text: ' to add a project')
                //                   ]),
                //             ),
                //           ),
                //         ],
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
          )),
    );
  }

