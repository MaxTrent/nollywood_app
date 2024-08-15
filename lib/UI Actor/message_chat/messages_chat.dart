import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/message_chat/message_chat_vm.dart';
import 'package:nitoons/components/app_loading_indicator.dart';
import 'package:nitoons/components/app_textfield.dart';
import 'package:nitoons/components/back_button.dart';
import 'package:nitoons/data/app_storage.dart';
import 'package:nitoons/data/socket_service.dart';
import 'package:nitoons/models/conversation_message_model.dart';
import 'package:nitoons/widgets/error_profile_picture.dart';

import '../../constants/app_colors.dart';
import '../../gen/assets.gen.dart';

class MessagesChat extends ConsumerWidget {
  MessagesChat(
      {Key? key,
      required this.conversationId,
      required this.fullName,
      required this.profilePicture});

  String conversationId;
  String fullName;
  String profilePicture;

  @override
  Widget build(BuildContext context, ref) {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    final User? currentUser = _auth.currentUser;
    // final userMessages = ref.watch(
    //     MessagesChatViewModel.getUserConversationMessagesProvider(
    //         conversationId));
    Stream<QuerySnapshot> _messagesStream = _firestore.collection('conversations/${conversationId}/messages')
        .orderBy('timestamp', descending: true)
        .snapshots();


    final streamSocket = StreamSocket();

    ref.read(socketServiceInitializerProvider.future);

    final viewModel = MessagesChatViewModel(ref);

    // viewModel.fetchMessages(conversationId);
    // viewModel.listenForRealTimeUpdates(conversationId);

    return FutureBuilder(
      future: SecureStorageHelper.getUserId(),
      builder: (context, userIdSnapshot) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            toolbarHeight: 70.h,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Divider(
                  height: 1,
                  color: Color(0xff3C3C43).withOpacity(0.29),
                )),
            leading: AppBackButton(),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Icon(Icons.more_vert),
              )
            ],
            title: Row(
              children: [
                CircleAvatar(
                    radius: 28.r,
                    backgroundColor: selectColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 26.r,
                      child: ClipOval(
                          child: Image.network(
                        profilePicture,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return ErrorProfilePicture();
                        },
                      )),
                    )),
                SizedBox(
                  width: 13.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'Adesua Etomi',
                      fullName,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 6.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: selectColor,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Online',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              StreamBuilder(
                stream: _messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(child: Center(child: Container()));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No messages found.'));
                  } else {
                    // final messages = snapshot.data!.data.results;
                    return Expanded(
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        controller: viewModel.scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final messageData = snapshot.data!.docs[index];
                          final message = messageData['text'];
                          final senderId = messageData['senderId'];
                          final userId = userIdSnapshot.data;
                          final isSentByMe = senderId == userId;

                          print('sender Id: $senderId');
                          print('userIdSnapshot: $userId');

                          // final message = messages[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: SafeArea(
                              child: Column(
                                children: [
                                  if (index == snapshot.data!.docs.length - 1) ...[
                                    SizedBox(height: 12.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 0.5.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: Color(0xffC4C4C4),
                                          ),
                                        ),
                                        SizedBox(width: 14.w),
                                        Text(
                                          'Today',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                fontSize: 12.sp,
                                                color: Color(0xff7C7C7C),
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 14.w),
                                        Container(
                                          height: 0.5.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: Color(0xffC4C4C4),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 22.h),
                                  ],
                                  isSentByMe
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 12.h),
                                                child: MessageSentBubble(
                                                  fullName: fullName,
                                                     profilePicture: profilePicture,
                                                  message: message,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    EdgeInsets.only(top: 12.h),
                                                child: MessageReceivedBubble(
                                                  fullName: fullName,
                                                  profilePicture: profilePicture,
                                                  message: message,
                                                ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),

      //             userMessages.when(data: (messages) {
      // //  final sortedMessages = messages.data.results.toSet().toList()
      // //                 ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

      //               return Expanded(
      //                 child: ListView.builder(
      //                   reverse: true,
      //                   shrinkWrap: true,
      //                   controller: viewModel.scrollController,
      //                   itemCount: messages.data.results.length,
      //                   itemBuilder: (context, index) {
      //                     final message = messages.data.results[index];
      //                     return Padding(
      //                       padding: EdgeInsets.symmetric(horizontal: 24.w),
      //                       child: SafeArea(
      //                         child: Column(
      //                           children: [
      //                             if (index == messages.data.results.length - 1) ...[
      //                               SizedBox(height: 12.h),
      //                               Row(
      //                                 mainAxisAlignment: MainAxisAlignment.center,
      //                                 children: [
      //                                   Container(
      //                                     height: 0.5.h,
      //                                     width: 100.w,
      //                                     decoration: BoxDecoration(
      //                                       color: Color(0xffC4C4C4),
      //                                     ),
      //                                   ),
      //                                   SizedBox(width: 14.w),
      //                                   Text(
      //                                     'Today',
      //                                     style: Theme.of(context)
      //                                         .textTheme
      //                                         .displaySmall!
      //                                         .copyWith(
      //                                           fontSize: 12.sp,
      //                                           color: Color(0xff7C7C7C),
      //                                         ),
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                   SizedBox(width: 14.w),
      //                                   Container(
      //                                     height: 0.5.h,
      //                                     width: 100.w,
      //                                     decoration: BoxDecoration(
      //                                       color: Color(0xffC4C4C4),
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                               SizedBox(height: 22.h),
      //                             ],
      //                             FutureBuilder<String?>(
      //                               future: userId(),
      //                               builder: (context, snapshot) {
      //                                 if (snapshot.connectionState ==
      //                                     ConnectionState.done) {
      //                                   final userIdValue = snapshot.data;
      //                                   print(message.sentBy);
      //                                   print(userIdValue);

      //                                   return message.sentBy == userIdValue
      //                                       ? Padding(
      //                                           padding:
      //                                               EdgeInsets.only(bottom: 12.h),
      //                                           child: MessageSentBubble(
      //                                             fullName:
      //                                                 "${message.userProfile.firstName} ${message.userProfile.lastName}",
      //                                             profilePicture: message
      //                                                 .userProfile.profilePicture,
      //                                             message: message.message,
      //                                           ),
      //                                         )
      //                                       : Padding(
      //                                           padding: EdgeInsets.only(top: 12.h),
      //                                           child: MessageReceivedBubble(
      //                                             fullName:
      //                                                 "${message.userProfile.firstName} ${message.userProfile.lastName}",
      //                                             profilePicture: message
      //                                                 .userProfile.profilePicture,
      //                                             message: message.message,
      //                                           ),
      //                                         );
      //                                 } else {
      //                                   return Container(color: Colors.transparent);
      //                                 }
      //                               },
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               );
      //             }, error: (error, _) {
      //               return Text('$error, $_');
      //             }, loading: () {
      //               return Container(
      //                 color: Colors.transparent,
      //               );
      //             }),

              // Expanded(
              //   child: ListView.builder(
              //     // itemCount: ,
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 24.w),
              //       child: SafeArea(
              //         child: Column(
              //           children: [
              //             SizedBox(
              //               height: 12.h,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Container(
              //                   height: 0.5.h,
              //                   width: 100.w,
              //                   decoration: BoxDecoration(
              //                     color: Color(0xffC4C4C4),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 14.w,
              //                 ),
              //                 Text(
              //                   'Today',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .displaySmall!
              //                       .copyWith(
              //                           fontSize: 12.sp,
              //                           color: Color(0xff7C7C7C)),
              //                   textAlign: TextAlign.center,
              //                 ),
              //                 SizedBox(
              //                   width: 14.w,
              //                 ),
              //                 Container(
              //                   height: 0.5.h,
              //                   width: 100.w,
              //                   decoration: BoxDecoration(
              //                     color: Color(0xffC4C4C4),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 22.h,
              //             ),
              //             MessageReceivedBubble(),
              //             SizedBox(height: 24.h),
              //             MessageSentBubble(),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                child: buildSendMessageTextField(viewModel, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSendMessageTextField(
      MessagesChatViewModel viewModel, WidgetRef ref) {
    return Row(
      children: [
        AppTextField(
          width: 275,
          controller: viewModel.messageController,
          hintText: 'Your message',
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: SvgPicture.asset(Assets.svgs.stickers),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: () => viewModel.messageText.isEmpty
              ? null
              : viewModel.sendMessage(conversationId),
          child: Container(
              height: 59.h,
              width: 48.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 1, color: Color(0xffE8E6EA))),
              child: Padding(
                padding: EdgeInsets.all(14.h),
                child: viewModel.messageText.isEmpty
                    ? SvgPicture.asset(
                        Assets.svgs.voice,
                        height: 20.h,
                        width: 20.w,
                      )
                    : Icon(Icons.send),
              )),
        )
      ],
    );
  }
}

class GroupChat extends StatelessWidget {
  GroupChat({super.key});

  final _groupMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.h,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                height: 1,
                color: Color(0xff3C3C43).withOpacity(0.29),
              )),
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
              padding: EdgeInsets.only(right: 20.w),
              child: Icon(Icons.more_vert),
            )
          ],
          title: Row(
            children: [
              CircleAvatar(
                  radius: 28.r,
                  backgroundColor: selectColor,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 26.r,
                    child: Image.asset(Assets.png.mikolo.path),
                  )),
              SizedBox(
                width: 13.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mikolo',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '24 participants',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 0.5.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Color(0xffC4C4C4),
                            ),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Text(
                            'Today',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 12.sp, color: Color(0xff7C7C7C)),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Container(
                            height: 0.5.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Color(0xffC4C4C4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      MessageReceivedBubble(
                        message: '',
                        profilePicture: '',
                        fullName: '',
                      ),
                      SizedBox(height: 24.h),
                      MessageSentBubble(
                        message: '',
                        profilePicture: '',
                        fullName: '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
              child: buildSendGroupMessageTextfield(),
            ),
          ],
        ),
      ),
    );
  }

  Row buildSendGroupMessageTextfield() {
    return Row(
      children: [
        AppTextField(
          width: 275,
          controller: _groupMessageController,
          hintText: 'Your message',
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: SvgPicture.asset(Assets.svgs.stickers),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Container(
            height: 59.h,
            width: 48.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(width: 1, color: Color(0xffE8E6EA))),
            child: Padding(
              padding: EdgeInsets.all(14.h),
              child: SvgPicture.asset(
                Assets.svgs.voice,
                height: 20.h,
                width: 20.w,
              ),
            ))
      ],
    );
  }
}

class MessageSentBubble extends StatelessWidget {
  MessageSentBubble(
      {Key? key,
      required this.message,
      required this.fullName,
      required this.profilePicture});

  String fullName;
  String profilePicture;
  String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: 260.w,
              decoration: BoxDecoration(
                  color: Color(0xffF3F3F3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Adesua',
                        fullName,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        // 'Haha truly! Nice to meet you Grace! What about a cup of coffee today evening? ☕',
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '2:55 PM',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 8.sp,
                                      color: Colors.black.withOpacity(0.4),
                                      fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            SvgPicture.asset(Assets.svgs.doubletick)
                          ],
                        ),
                      ),
                    ]),
              )),
          SizedBox(
            width: 7.w,
          ),
          CircleAvatar(
            radius: 12.r,
            child: ClipOval(
                child: Image.network(profilePicture, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
              return ErrorProfilePicture();
            })),
          ),
        ],
      ),
    );
  }
}

class MessageReceivedBubble extends StatelessWidget {
  MessageReceivedBubble(
      {Key? key,
      required this.fullName,
      required this.message,
      required this.profilePicture});

  String fullName;
  String profilePicture;
  String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12.r,
            child: ClipOval(
              child: Image.network(
                profilePicture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ErrorProfilePicture();
                },
              ),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          Container(
              width: 260.w,
              decoration: BoxDecoration(
                  color: Color(0xffFDF2F3),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Adesua Etomi',
                        fullName,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        // 'Hi Jake, how are you? I saw on the app that we’ve crossed paths several times this week 😄',
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '2:55 PM',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 8.sp,
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
