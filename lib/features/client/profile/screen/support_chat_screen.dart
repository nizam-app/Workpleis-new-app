import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  static const String routeName = '/support-chat';

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text:
          'To receive additional assistance, Please explore the Tasker suport there you can view and complate learning paths to help jumpstart your success on Upwork. You may also find.',
      isUser: false,
      timeLabel: '3.10 PM',
    ),
    _ChatMessage(
      text: 'Yes! I need additional support',
      isUser: true,
      timeLabel: '3.15 PM',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.insert(
        0,
        _ChatMessage(text: text, isUser: true, timeLabel: 'Now'),
      );
    });

    _messageController.clear();
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AllColor.grey100,
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
                  Expanded(
                    child: Center(
                      child: Text(
                        'Support Chat',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w), // Balance the back button
                ],
              ),
            ),

            // Chat Messages Area
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: message.isUser
                        ? _UserMessageBubble(
                            text: message.text,
                            timeLabel: message.timeLabel,
                          )
                        : _SupportMessageBubble(
                            text: message.text,
                            timeLabel: message.timeLabel,
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
                          color: const Color(0xFFCAFF45), // Lime green
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
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final String timeLabel;

  _ChatMessage({
    required this.text,
    required this.isUser,
    required this.timeLabel,
  });
}

// User Message Bubble (Right-aligned, Lime Green)
class _UserMessageBubble extends StatelessWidget {
  final String text;
  final String timeLabel;

  const _UserMessageBubble({required this.text, required this.timeLabel});

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
                        color: const Color(0xFF1A1A1A), // Black
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

// Support Message Bubble (Left-aligned, Light Grey)
class _SupportMessageBubble extends StatelessWidget {
  final String text;
  final String timeLabel;

  const _SupportMessageBubble({required this.text, required this.timeLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Support Profile Icon
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xFFCAFF45), // Light green
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.support_agent,
                size: 18.sp,
                color: AllColor.white,
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
                        color: const Color(0xFF1A1A1A), // Black
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
