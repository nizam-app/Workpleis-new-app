import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ClientChatScreen extends StatefulWidget {
  const ClientChatScreen({
    super.key,
    required this.peerName,
    this.isOnline = true,
    this.peerAvatarAsset = 'assets/images/profile.png',
  });

  static const String routeName = '/client-chat';

  final String peerName;
  final bool isOnline;
  final String peerAvatarAsset;

  @override
  State<ClientChatScreen> createState() => _ClientChatScreenState();
}

class _ClientChatScreenState extends State<ClientChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _blockReasonController = TextEditingController();

  bool _showMenu = false;
  bool _showBlockUserDialog = false;

  late final List<_ChatMessage> _messages = <_ChatMessage>[
    _ChatMessage.sentText(
      text: "As-salamu alaykum, How are you? Kazi Mahbub",
      timeLabel: '3.15 PM',
    ),
    _ChatMessage.receivedText(
      text:
          "Wa alaykumu s-salam, I'm Fine & and you? Do you design experience?",
      timeLabel: '3.10 PM',
    ),
    _ChatMessage.sentText(
      text:
          "Yes, Kazi Mahbub, I have extensive experience and can provide you with links to my work.",
      timeLabel: '3.11 PM',
    ),
    _ChatMessage.sentText(text: "Just wi8 brother", timeLabel: '3.11 PM'),
    _ChatMessage.receivedText(
      text: "Of course, I'd be happy to help.",
      timeLabel: '3.10 PM',
    ),
    _ChatMessage.sentText(
      text:
          "Here is link:\nhttps://dribbble.com/borkatullah\nhttps://flames/borkatullah/255",
      timeLabel: '3.11 PM',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _blockReasonController.dispose();
    super.dispose();
  }

  void _openBlockUserDialog() {
    setState(() {
      _showMenu = false;
      _showBlockUserDialog = true;
    });
  }

  void _hideBlockUserDialog() {
    setState(() {
      _showBlockUserDialog = false;
      _blockReasonController.clear();
    });
  }

  void _sendBlockRequest() {
    final reason = _blockReasonController.text.trim();
    // Handle block user logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User blocked${reason.isNotEmpty ? ': $reason' : ''}'),
      ),
    );
    _hideBlockUserDialog();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage.sentText(text: text, timeLabel: 'Now'));
    });

    _messageController.clear();
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: GestureDetector(
        onTap: () {
          if (_showMenu) {
            setState(() {
              _showMenu = false;
            });
          }
        },
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  // App Bar with Profile
                  Container(
                    color: AllColor.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        // Back Button
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              size: 18.sp,
                              color: AllColor.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Profile Picture
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCAFF45),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              widget.peerAvatarAsset,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFCAFF45),
                                  child: Icon(
                                    Icons.person,
                                    size: 24.sp,
                                    color: AllColor.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Name and Status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.peerName,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AllColor.black,
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                widget.isOnline ? 'Online' : 'Offline',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AllColor.black,
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Menu Button
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showMenu = !_showMenu;
                                });
                              },
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: AllColor.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.more_vert,
                                  size: 20.sp,
                                  color: AllColor.black,
                                ),
                              ),
                            ),
                            if (_showMenu)
                              Positioned(
                                right: 0,
                                top: 45.h,
                                child: Container(
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    color: AllColor.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {}, // Prevent parent tap
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: _openBlockUserDialog,
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                              vertical: 12.h,
                                            ),
                                            child: Text(
                                              'Block User',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red,
                                                fontFamily: 'sf_pro',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Date Separator
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      'Oct 17, 2022',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ),

                  // Chat Messages Area
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: false,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: message.isSent
                              ? _SentMessageBubble(
                                  text: message.text,
                                  timeLabel: message.timeLabel,
                                )
                              : _ReceivedMessageBubble(
                                  text: message.text,
                                  timeLabel: message.timeLabel,
                                  avatarAsset: widget.peerAvatarAsset,
                                ),
                        );
                      },
                    ),
                  ),

                  // Bottom Input Area
                  Container(
                    padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
                    decoration: BoxDecoration(
                      color: AllColor.white,
                      border: Border(
                        top: BorderSide(color: AllColor.grey200, width: 1),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text Input Field
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(maxHeight: 100.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: TextField(
                                controller: _messageController,
                                maxLines: null,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  hintText: 'Type here...',
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AllColor.grey600,
                                    fontFamily: 'sf_pro',
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: Icon(
                                      Icons.attach_file,
                                      size: 20.sp,
                                      color: AllColor.grey600,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AllColor.black,
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Send Button
                          GestureDetector(
                            onTap: _sendMessage,
                            child: Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: AllColor.black,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.send,
                                size: 20.sp,
                                color: AllColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Block User Dialog
            if (_showBlockUserDialog)
              _BlockUserDialog(
                controller: _blockReasonController,
                onClose: _hideBlockUserDialog,
                onSend: _sendBlockRequest,
              ),
          ],
        ),
      ),
    );
  }
}

// Block User Confirmation Dialog
class _BlockUserDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClose;
  final VoidCallback onSend;

  const _BlockUserDialog({
    required this.controller,
    required this.onClose,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: GestureDetector(
              onTap: onClose,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
        ),
        // Dialog content
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: AllColor.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Close Button
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Block User',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                      GestureDetector(
                        onTap: onClose,
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 18.sp,
                            color: AllColor.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text Input Area
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 120.h,
                      maxHeight: 200.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.all(16.w),
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      minLines: 4,
                      textInputAction: TextInputAction.newline,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText:
                            'This is client spam. The Tasker app is looking quite bad.',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.grey600,
                          fontFamily: 'sf_pro',
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ),
                ),
                // Sent Button
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: GestureDetector(
                    onTap: onSend,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AllColor.black,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Sent',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AllColor.white,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatMessage {
  final String text;
  final String timeLabel;
  final bool isSent;

  _ChatMessage({
    required this.text,
    required this.timeLabel,
    required this.isSent,
  });

  factory _ChatMessage.sentText({
    required String text,
    required String timeLabel,
  }) {
    return _ChatMessage(text: text, timeLabel: timeLabel, isSent: true);
  }

  factory _ChatMessage.receivedText({
    required String text,
    required String timeLabel,
  }) {
    return _ChatMessage(text: text, timeLabel: timeLabel, isSent: false);
  }
}

// Sent Message Bubble (Right-aligned, Lime Green)
class _SentMessageBubble extends StatelessWidget {
  final String text;
  final String timeLabel;

  const _SentMessageBubble({required this.text, required this.timeLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCAFF45), // Lime green
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        height: 1.4,
                      ),
                    ),
                  ),
                  // Tail on bottom-right
                  Positioned(
                    bottom: 0,
                    right: -6.w,
                    child: CustomPaint(
                      size: Size(12.w, 12.h),
                      painter: _MessageTailPainter(
                        color: const Color(0xFFCAFF45),
                        isRight: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Text(
            timeLabel,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.grey600,
              fontFamily: 'sf_pro',
            ),
          ),
        ),
      ],
    );
  }
}

// Received Message Bubble (Left-aligned, Light Grey)
class _ReceivedMessageBubble extends StatelessWidget {
  final String text;
  final String timeLabel;
  final String avatarAsset;

  const _ReceivedMessageBubble({
    required this.text,
    required this.timeLabel,
    required this.avatarAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xFFCAFF45),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  avatarAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFCAFF45),
                      child: Icon(
                        Icons.person,
                        size: 18.sp,
                        color: AllColor.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2), // Very light grey
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        height: 1.4,
                      ),
                    ),
                  ),
                  // Tail on bottom-left
                  Positioned(
                    bottom: 0,
                    left: -6.w,
                    child: CustomPaint(
                      size: Size(12.w, 12.h),
                      painter: _MessageTailPainter(
                        color: const Color(0xFFF2F2F2),
                        isRight: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: 40.w), // Align with message start
          child: Text(
            timeLabel,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.grey600,
              fontFamily: 'sf_pro',
            ),
          ),
        ),
      ],
    );
  }
}

// Custom Painter for Message Tail
class _MessageTailPainter extends CustomPainter {
  final Color color;
  final bool isRight;

  _MessageTailPainter({required this.color, required this.isRight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isRight) {
      // Right tail (pointing right)
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height * 0.5);
      path.lineTo(0, 0);
      path.close();
    } else {
      // Left tail (pointing left)
      path.moveTo(size.width, size.height);
      path.lineTo(0, size.height * 0.5);
      path.lineTo(size.width, 0);
      path.close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
