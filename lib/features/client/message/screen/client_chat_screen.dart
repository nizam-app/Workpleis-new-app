import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
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

  bool _showBlockUserDialog = false;
  bool _showBlockConfirmationDialog = false;
  bool _isUserBlocked = false;

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
          "Here is link: https://dribbble.com/borkatullah https://flames/borkatullah/255",
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
    setState(() {
      _showBlockUserDialog = false;
      _showBlockConfirmationDialog = true;
    });
  }

  void _hideBlockConfirmationDialog() {
    setState(() {
      _showBlockConfirmationDialog = false;
    });
  }

  void _confirmBlockUser() {
    final reason = _blockReasonController.text.trim();
    setState(() {
      _isUserBlocked = true;
      _showBlockConfirmationDialog = false;
      _blockReasonController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User blocked${reason.isNotEmpty ? ': $reason' : ''}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _sendMessage() {
    if (_isUserBlocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You cannot send messages to a blocked user'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

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
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Column(
              children: [
                // App Bar
                Container(
                  color: const Color(0xFFF6F6F6),
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
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              width: 2.w,
                              color: const Color(0xFFE0E0E0),
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
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            widget.peerAvatarAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFF4CAF50),
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
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: AllColor.black,
                                fontFamily: 'sf_pro',
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              widget.isOnline ? 'Online' : 'Offline',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF696969),
                                fontFamily: 'sf_pro',
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ✅ FIXED MENU: PopupMenuButton (Overlay-based, tap always works)
                      PopupMenuButton<String>(
                        color: AllColor.white,
                        elevation: 8,
                        offset: Offset(0, 52.h), // show under the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        onSelected: (value) {
                          if (value == 'block') {
                            _openBlockUserDialog();
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem<String>(
                            value: 'block',
                            child: SizedBox(
                              width: 90.w,
                              child: Text(
                                textAlign: TextAlign.center,
                                'Block User',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFF0000),
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                            ),
                          ),
                        ],
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: AllColor.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: const Color(0xFFD0D0D0),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.more_vert,
                            size: 20.sp,
                            color: AllColor.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Date Separator
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(
                    child: Text(
                      'Oct 17, 2022',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF696969),
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ),
                ),

                // Chat Messages
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
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
                    border: const Border(
                      top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 100.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: TextField(
                              controller: _messageController,
                              enabled: !_isUserBlocked,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                hintText: _isUserBlocked
                                    ? 'Type here...'
                                    //'User is blocked. You cannot send messages.'
                                    : 'Type here...',
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFA8A8A8),
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
                                    color: _isUserBlocked
                                        ? const Color(0xFFB0B0B0)
                                        : const Color(0xFF696969),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: _isUserBlocked
                                    ? const Color(0xFFB0B0B0)
                                    : AllColor.black,
                                fontFamily: 'sf_pro',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: _sendMessage,
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: _isUserBlocked
                                  ? const Color(0xFFCCCCCC)
                                  : const Color(0xFFCAFF45), // Lime green
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.send,
                              size: 20.sp,
                              color: _isUserBlocked
                                  ? const Color(0xFF999999)
                                  : AllColor.white,
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
            Positioned.fill(
              child: _BlockUserDialog(
                controller: _blockReasonController,
                onClose: _hideBlockUserDialog,
                onSend: _sendBlockRequest,
              ),
            ),

          // Block Confirmation Dialog
          if (_showBlockConfirmationDialog)
            Positioned.fill(
              child: _BlockConfirmationDialog(
                onClose: _hideBlockConfirmationDialog,
                onConfirm: _confirmBlockUser,
              ),
            ),
        ],
      ),
    );
  }
}

// Block User Dialog
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
        // ✅ FIX: ClipRect added
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: GestureDetector(
                onTap: onClose,
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
        ),
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
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0E0E0),
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

// Block Confirmation Dialog
class _BlockConfirmationDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onConfirm;

  const _BlockConfirmationDialog({
    required this.onClose,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ✅ FIX: ClipRect added
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: GestureDetector(
                onTap: onClose,
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
        ),
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
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0E0E0),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: Text(
                    'User will be blocked.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.black,
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AllColor.black,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
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

// ----------------------- Models -----------------------

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

// ----------------------- Bubbles -----------------------

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
                      color: const Color(0xFFCAFF45),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(4.r),
                      ),
                    ),
                    child: _buildTextWithLinks(text),
                  ),
                  Positioned(
                    bottom: 0,
                    left: -6.w,
                    child: CustomPaint(
                      size: Size(12.w, 12.h),
                      painter: _MessageTailPainter(
                        color: const Color(0xFFCAFF45),
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
          padding: EdgeInsets.only(right: 8.w),
          child: Text(
            timeLabel,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF696969),
              fontFamily: 'sf_pro',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextWithLinks(String text) {
    final urlPattern = RegExp(r'https?://[^\s]+', caseSensitive: false);
    final matches = urlPattern.allMatches(text);

    if (matches.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF1A1A1A),
          fontFamily: 'sf_pro',
          height: 1.4,
        ),
      );
    }

    final spans = <TextSpan>[];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1A1A1A),
              fontFamily: 'sf_pro',
              height: 1.4,
            ),
          ),
        );
      }

      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.blue,
            fontFamily: 'sf_pro',
            height: 1.4,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(url);
              if (await url_launcher.canLaunchUrl(uri)) {
                await url_launcher.launchUrl(
                  uri,
                  mode: url_launcher.LaunchMode.externalApplication,
                );
              }
            },
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF1A1A1A),
            fontFamily: 'sf_pro',
            height: 1.4,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}

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
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  avatarAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF4CAF50),
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
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.r),
                        topRight: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1A1A1A),
                        fontFamily: 'sf_pro',
                        height: 1.4,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: -6.w,
                    child: CustomPaint(
                      size: Size(12.w, 12.h),
                      painter: _MessageTailPainter(
                        color: const Color(0xFFE8E8E8),
                        isRight: false,
                        isTop: true,
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
          padding: EdgeInsets.only(left: 40.w),
          child: Text(
            timeLabel,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF696969),
              fontFamily: 'sf_pro',
            ),
          ),
        ),
      ],
    );
  }
}

class _MessageTailPainter extends CustomPainter {
  final Color color;
  final bool isRight;
  final bool isTop;

  _MessageTailPainter({
    required this.color,
    required this.isRight,
    this.isTop = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (isRight) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height * 0.5);
      path.lineTo(0, 0);
      path.close();
    } else {
      if (isTop) {
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height * 0.5);
        path.lineTo(size.width, size.height);
        path.close();
      } else {
        path.moveTo(size.width, size.height);
        path.lineTo(0, size.height * 0.5);
        path.lineTo(size.width, 0);
        path.close();
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
