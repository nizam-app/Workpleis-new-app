import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/service/screen/service_jobs/service_job_full_details_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.peerName,
    this.isOnline = true,
    this.peerAvatarAsset = 'assets/images/profile.png',
  });

  static const String routeName = '/chat';

  final String peerName;
  final bool isOnline;
  final String peerAvatarAsset;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _composerController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late final List<_ChatMessage> _messages = <_ChatMessage>[
    _ChatMessage.receivedText(
      text: "Of course, I'd be happy to help.",
      timeLabel: '3:10 PM',
    ),
    _ChatMessage.sentText(
      text:
          'Here is link:\nhttps://dribbble.com/borkatullah\nhttps://flames/borkatullah/255',
      timeLabel: '3:11 PM',
      style: _SentTextStyle.linkBlock,
    ),
    _ChatMessage.receivedOffer(
      offer: const _OfferCardData(
        title: 'Describe offer',
        description:
            'I have two tickets for the Al-Nassr  Paris match for sale design',
        priceLabel: r'$ 1,300',
        timeLabel: '5 Day',
      ),
      timeLabel: '3:10 PM',
    ),
    _ChatMessage.sentText(
      text: 'Thank you kazi, I have accepted your offer',
      timeLabel: '3:11 PM',
      style: _SentTextStyle.success,
    ),
  ];

  @override
  void dispose() {
    _composerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _sendMessage() {
    final text = _composerController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        _ChatMessage.sentText(
          text: text,
          timeLabel: TimeOfDay.now().format(context),
          style: _SentTextStyle.regular,
        ),
      );
    });

    _composerController.clear();
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          const _TopGlow(),
          SafeArea(
            bottom: false,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 0),
                    child: _ChatHeader(
                      peerName: widget.peerName,
                      isOnline: widget.isOnline,
                      avatarAsset: widget.peerAvatarAsset,
                      onBack: () => context.pop(),
                      onMenu: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('More options (coming soon)'),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Oct 17, 2022',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: const Color(0xFF23262F),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
                      itemCount: _messages.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return switch (message.kind) {
                          _ChatMessageKind.receivedText => _ReceivedTextMessage(
                            avatarAsset: widget.peerAvatarAsset,
                            text: message.text ?? '',
                            timeLabel: message.timeLabel,
                          ),
                          _ChatMessageKind.sentText => _SentTextMessage(
                            text: message.text ?? '',
                            timeLabel: message.timeLabel,
                            style: message.sentStyle ?? _SentTextStyle.regular,
                          ),
                          _ChatMessageKind.receivedOffer =>
                            _ReceivedOfferMessage(
                              avatarAsset: widget.peerAvatarAsset,
                              offer: message.offer!,
                              timeLabel: message.timeLabel,
                              onViewJob: () {
                                context.push(
                                  ServiceJobFullDetailsScreen.routeName,
                                  extra: <String, dynamic>{
                                    'title': message.offer!.description,
                                    'price': message.offer!.priceLabel,
                                    'quote': message.offer!.timeLabel,
                                    'location': 'Jaddah',
                                    'categories': const [
                                      'Design',
                                      'Banner Design',
                                    ],
                                    'isFromChat': true,
                                  },
                                );
                              },
                              onAccept: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Accept Offer (coming soon)'),
                                  ),
                                );
                              },
                            ),
                        };
                      },
                    ),
                  ),
                  _ChatComposer(
                    controller: _composerController,
                    onAttach: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attach file (coming soon)'),
                        ),
                      );
                    },
                    onSend: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _ChatMessageKind { receivedText, sentText, receivedOffer }

enum _SentTextStyle { regular, linkBlock, success }

class _ChatMessage {
  final _ChatMessageKind kind;
  final String timeLabel;
  final String? text;
  final _OfferCardData? offer;
  final _SentTextStyle? sentStyle;

  const _ChatMessage._({
    required this.kind,
    required this.timeLabel,
    this.text,
    this.offer,
    this.sentStyle,
  });

  factory _ChatMessage.receivedText({
    required String text,
    required String timeLabel,
  }) {
    return _ChatMessage._(
      kind: _ChatMessageKind.receivedText,
      text: text,
      timeLabel: timeLabel,
    );
  }

  factory _ChatMessage.sentText({
    required String text,
    required String timeLabel,
    required _SentTextStyle style,
  }) {
    return _ChatMessage._(
      kind: _ChatMessageKind.sentText,
      text: text,
      timeLabel: timeLabel,
      sentStyle: style,
    );
  }

  factory _ChatMessage.receivedOffer({
    required _OfferCardData offer,
    required String timeLabel,
  }) {
    return _ChatMessage._(
      kind: _ChatMessageKind.receivedOffer,
      offer: offer,
      timeLabel: timeLabel,
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

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.peerName,
    required this.isOnline,
    required this.avatarAsset,
    required this.onBack,
    required this.onMenu,
  });

  final String peerName;
  final bool isOnline;
  final String avatarAsset;
  final VoidCallback onBack;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _HeaderIconButton(
          icon: Icons.arrow_back_ios_new,
          onTap: onBack,
          borderColor: const Color(0xFFE0E0E0),
          borderRadius: 8.r,
        ),
        SizedBox(width: 12.w),
        _Avatar(asset: avatarAsset, size: 50.w),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                peerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: AllColor.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                isOnline ? 'Online' : 'Offline',
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
        _HeaderIconButton(
          icon: Icons.more_vert,
          onTap: onMenu,
          borderColor: const Color(0xFFDCDCDC),
          borderRadius: 14.r,
          fillColor: AllColor.white,
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    required this.borderColor,
    required this.borderRadius,
    this.fillColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color borderColor;
  final double borderRadius;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor),
          ),
          child: Icon(icon, size: 20.sp, color: const Color(0xFF111111)),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.asset, required this.size});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF8EC800),
        shape: BoxShape.circle,
      ),
      child: ClipOval(child: Image.asset(asset, fit: BoxFit.cover)),
    );
  }
}

class _ReceivedTextMessage extends StatelessWidget {
  const _ReceivedTextMessage({
    required this.avatarAsset,
    required this.text,
    required this.timeLabel,
  });

  final String avatarAsset;
  final String text;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Avatar(asset: avatarAsset, size: 36.w),
            SizedBox(width: 16.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F5F6),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: const Color(0xFF141416),
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.only(left: (36.w + 16.w)),
          child: _MessageTime(
            timeLabel: timeLabel,
            align: Alignment.centerRight,
          ),
        ),
      ],
    );
  }
}

class _SentTextMessage extends StatelessWidget {
  const _SentTextMessage({
    required this.text,
    required this.timeLabel,
    required this.style,
  });

  final String text;
  final String timeLabel;
  final _SentTextStyle style;

  @override
  Widget build(BuildContext context) {
    final background = AllColor.bgcolor;
    final textColor = const Color(0xFF000080);
    final fontSize = style == _SentTextStyle.linkBlock ? 14.sp : 14.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 320.w),
          child: Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'sf_pro',
                fontWeight: FontWeight.w400,
                fontSize: fontSize,
                color: textColor,
                height: 1.3,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        _MessageTime(timeLabel: timeLabel, align: Alignment.centerRight),
      ],
    );
  }
}

class _ReceivedOfferMessage extends StatelessWidget {
  const _ReceivedOfferMessage({
    required this.avatarAsset,
    required this.offer,
    required this.timeLabel,
    required this.onViewJob,
    required this.onAccept,
  });

  final String avatarAsset;
  final _OfferCardData offer;
  final String timeLabel;
  final VoidCallback onViewJob;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Avatar(asset: avatarAsset, size: 36.w),
            SizedBox(width: 16.w),
            Expanded(
              child: _OfferCard(
                data: offer,
                onViewJob: onViewJob,
                onAccept: onAccept,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.only(left: (36.w + 16.w)),
          child: _MessageTime(
            timeLabel: timeLabel,
            align: Alignment.centerRight,
          ),
        ),
      ],
    );
  }
}

class _MessageTime extends StatelessWidget {
  const _MessageTime({required this.timeLabel, required this.align});

  final String timeLabel;
  final Alignment align;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Text(
        timeLabel,
        style: TextStyle(
          fontFamily: 'sf_pro',
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          color: const Color(0xFFDEE0E2),
          height: 1.2,
        ),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({
    required this.controller,
    required this.onAttach,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onAttach;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AllColor.white,
          border: Border(top: BorderSide(color: Color(0xFFEDEDED))),
        ),
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => onSend(),
                        style: TextStyle(
                          fontFamily: 'sf_pro',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AllColor.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type here...',
                          hintStyle: TextStyle(
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: const Color(0xFFA8A8A8),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onAttach,
                      icon: Icon(
                        Icons.attach_file,
                        size: 22.sp,
                        color: const Color(0xFF756D6D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16.w),
            SizedBox(
              width: 56.w,
              height: 56.w,
              child: Material(
                color: AllColor.black,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onSend,
                  child: Icon(Icons.send, color: AllColor.white, size: 22.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferCardData {
  final String title;
  final String description;
  final String priceLabel;
  final String timeLabel;

  const _OfferCardData({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.timeLabel,
  });
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.data,
    required this.onViewJob,
    required this.onAccept,
  });

  final _OfferCardData data;
  final VoidCallback onViewJob;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE1E8D2)),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Colors.black.withAlpha(77),
              height: 1.2,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            data.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AllColor.black,
              height: 1.3,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _OfferInfoCard(label: 'Price', value: data.priceLabel),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _OfferInfoCard(label: 'Time', value: data.timeLabel),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _PillButton(
                  label: 'View Job',
                  backgroundColor: const Color(0xFFE3E3E3).withAlpha(153),
                  textColor: AllColor.black,
                  onTap: onViewJob,
                  borderColor: Colors.transparent,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _PillButton(
                  label: 'Accept Offer',
                  backgroundColor: AllColor.black,
                  textColor: AllColor.white,
                  onTap: onAccept,
                  borderColor: Colors.black.withAlpha(77),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OfferInfoCard extends StatelessWidget {
  const _OfferInfoCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE1E8D2)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Colors.black.withAlpha(107),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AllColor.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    required this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(66.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(66.r),
        child: Container(
          height: 36.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(66.r),
            border: Border.all(color: borderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'sf_pro',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
