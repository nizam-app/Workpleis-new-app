import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/service/message/screen/chat_screen.dart';
import 'package:workpleis/features/client/message/screen/client_chat_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, this.isClient = false});

  static const String routeName = '/message';
  
  final bool isClient;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _searchController = TextEditingController();

  static final List<_ConversationPreview> _conversations =
      <_ConversationPreview>[
        _ConversationPreview(
          name: 'Theresa Webb',
          subtitle: 'Car Engineer - Back part',
          lastMessage: 'Kazi Mahbub : Are you online now, Nahid?',
          dateLabel: '3/1/24',
          avatarColor: Color(0xFFEAF7D9),
        ),
        _ConversationPreview(
          name: 'Jerome Bell',
          subtitle: 'Fjdf',
          lastMessage: 'Kazi Mahbub : Are you online now, Nahid?',
          dateLabel: '3/1/24',
          avatarColor: Color(0xFFD8EBCB),
        ),
        _ConversationPreview(
          name: 'Cody Fisher',
          subtitle: 'Car Engineer - Back part',
          lastMessage: 'Kazi Mahbub : Are you online now, Nahid?',
          dateLabel: '3/1/24',
          avatarColor: Color(0xFFF3F5F7),
        ),
        _ConversationPreview(
          name: 'Albert Flores',
          subtitle: 'Car Engineer - Back part',
          lastMessage: 'Kazi Mahbub : Are you online now, Nahid?',
          dateLabel: '3/1/24',
          avatarColor: Color(0xFFE2E8F0),
        ),
        _ConversationPreview(
          name: 'Kathryn Murphy',
          subtitle: 'Car Engineer - Back part',
          lastMessage: 'Kazi Mahbub : Are you online now, Nahid?',
          dateLabel: '3/1/24',
          avatarColor: Color(0xFFEAF7D9),
        ),
        _ConversationPreview(
          name: 'Annette Black',
          subtitle: 'Car Engineer - Back part',
          lastMessage: 'Kazi Mahbub : Are you online now, Nahid?',
          dateLabel: '3/1/24',
          avatarColor: Color(0xFFD8EBCB),
        ),
        _ConversationPreview(
          name: 'Devon Lane',
          subtitle: 'Car Engineer - Back part',
          lastMessage: 'Kazi Mahbub : Are you online now, Nahid?',
          dateLabel: '3/1/24',
          avatarColor: Color(0xFFF3F5F7),
        ),
      ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _conversations
        : _conversations.where((c) => c.matches(query)).toList(growable: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          const _TopGlow(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 10.h),
                  child: Text(
                    'Messages',
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w700,
                      fontSize: 34.sp,
                      color: AllColor.black,
                      height: 1.1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SearchField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      _FilterButton(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Filter (coming soon)'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            'No messages found',
                            style: TextStyle(
                              fontFamily: 'sf_pro',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Colors.black.withAlpha(115),
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFEFEFF0),
                          ),
                          itemBuilder: (context, index) {
                            final conversation = filtered[index];
                            return _ConversationTile(
                              conversation: conversation,
                              onTap: () {
                                if (widget.isClient) {
                                  context.push(
                                    ClientChatScreen.routeName,
                                    extra: <String, dynamic>{
                                      'peerName': conversation.name,
                                      'isOnline': true,
                                    },
                                  );
                                } else {
                                  context.push(
                                    ChatScreen.routeName,
                                    extra: <String, dynamic>{
                                      'peerName': conversation.name,
                                      'isOnline': true,
                                    },
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopGlow extends StatelessWidget {
  const _TopGlow();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -140.h,
      left: -220.w,
      right: -220.w,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(
            height: 220.h,
            decoration: BoxDecoration(
              color: const Color(0xFFD8EBCB).withAlpha(128),
              borderRadius: BorderRadius.circular(200.r),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const _SearchField({required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51.h,
      decoration: BoxDecoration(
        color: AllColor.white,
        border: Border.all(color: const Color(0xFFDEDFe5)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: TextStyle(
          fontFamily: 'sf_pro',
          fontWeight: FontWeight.w400,
          fontSize: 17.sp,
          color: AllColor.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            fontFamily: 'sf_pro',
            fontWeight: FontWeight.w400,
            fontSize: 17.sp,
            color: const Color(0x993C3C43),
            letterSpacing: -0.43,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 22.sp,
            color: Colors.black.withAlpha(77),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const _FilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: SvgPicture.asset(
            'assets/images/filter_icon.svg',
            width: 24.w,
            height: 24.w,
          ),
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final _ConversationPreview conversation;
  final VoidCallback onTap;

  const _ConversationTile({required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Avatar(name: conversation.name, color: conversation.avatarColor),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            conversation.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'sf_pro',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AllColor.black,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            conversation.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'sf_pro',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Colors.black.withAlpha(77),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            conversation.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'sf_pro',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: const Color(0xB71B1F26),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      conversation.dateLabel,
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: const Color(0xFF696969),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final Color color;

  const _Avatar({required this.name, required this.color});

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    final first = parts.first.isNotEmpty ? parts.first[0] : '';
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.r,
      backgroundColor: color,
      child: Text(
        _initials,
        style: TextStyle(
          fontFamily: 'sf_pro',
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
          color: AllColor.black,
        ),
      ),
    );
  }
}

class _ConversationPreview {
  final String name;
  final String subtitle;
  final String lastMessage;
  final String dateLabel;
  final Color avatarColor;

  const _ConversationPreview({
    required this.name,
    required this.subtitle,
    required this.lastMessage,
    required this.dateLabel,
    required this.avatarColor,
  });

  bool matches(String query) {
    if (query.isEmpty) return true;
    return name.toLowerCase().contains(query) ||
        subtitle.toLowerCase().contains(query) ||
        lastMessage.toLowerCase().contains(query);
  }
}
