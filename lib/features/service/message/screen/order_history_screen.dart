import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

/// Flutter conversion of `lib/features/service/screen/react.tsx`.
///
/// This is the "Order History" / "Delivery Process" screen with:
/// - Status bar (iPhone style)
/// - Header with back arrow and title "Delivery Process"
/// - Progress timeline showing two steps (Progress and Delivery)
/// - Bottom button "Job delivered"
/// - Message icon button
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  static const String routeName = '/order_history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Stack(
          children: [
            // Status Bar (iPhone style)
            // _StatusBar(),

            // Header Container
            _HeaderContainer(onBackTap: () => context.pop()),

            // Progress Section Title
            Positioned(
              left: 24.w,
              top: 138.h,
              child: Text(
                'Progress',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AllColor.black,
                  fontFamily: 'SF Pro Display',
                ),
              ),
            ),

            // Review Container with Timeline
            Positioned(left: 24.w, top: 183.h, child: _ReviewContainer()),

            // Review Card
            Positioned(
              left: 24.w,
              top: 632.h,
              child: _ReviewCard(),
            ),

            // Bottom Section (Button + Home Indicator)
            _BottomSection(),
          ],
        ),
      ),
    );
  }
}

/// Header Container with Back Arrow, Title, and Message Button
class _HeaderContainer extends StatelessWidget {
  final VoidCallback onBackTap;

  const _HeaderContainer({required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 15.h,
      child: Container(
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back Arrow Button (left)
            Material(
              color: AllColor.white,
              borderRadius: BorderRadius.circular(8.r),
              child: InkWell(
                onTap: onBackTap,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20.sp,
                    color: const Color(0xFF111111),
                  ),
                ),
              ),
            ),

            // Title (centered)
            Text(
              'Delivery Process',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AllColor.black,
                fontFamily: 'SF Pro Display',
              ),
            ),

            // Message Icon Button (right)
            Material(
              color: AllColor.white,
              borderRadius: BorderRadius.circular(8.r),
              child: InkWell(
                onTap: () {
                  // Handle message button tap
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDCDCDC)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.mail_outline,
                    size: 20.sp,
                    color: const Color(0xFF111111),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Review Container with Timeline
class _ReviewContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Card
        Container(
          width: 382.w,
          height: 429.h,
          decoration: BoxDecoration(
            color: AllColor.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFF2F2F2)),
          ),
        ),

        // Timeline
        Positioned(left: 42.w, top: 24.h, child: _Timeline()),

        // Progress Frame
        Positioned(left: 86.w, top: 24.h, child: _ProgressFrame()),

        // Delivery Frame
        Positioned(left: 86.w, top: 127.h, child: _DeliveryFrame()),
      ],
    );
  }
}

/// Timeline Component
class _Timeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(32.w, 134.h), painter: _TimelinePainter());
  }
}

/// Timeline Painter
class _TimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF8EC800)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFF8EC800)
      ..style = PaintingStyle.fill;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFF8EC800)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    // Vertical line
    canvas.drawLine(
      Offset(size.width * 0.53125, size.height * 0.2015),
      Offset(size.width * 0.53125, size.height * 0.9104),
      paint,
    );

    // Top circle (completed)
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.1194),
      16,
      fillPaint,
    );

    // Checkmark in top circle
    final checkPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final centerX = size.width * 0.5;
    final centerY = size.height * 0.1194;
    final checkPath = Path()
      ..moveTo(centerX - 5, centerY)
      ..lineTo(centerX - 1, centerY + 4)
      ..lineTo(centerX + 5, centerY - 3);
    canvas.drawPath(checkPath, checkPaint);

    // Bottom circle (in progress)
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.9104),
      8.5,
      whitePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.9104),
      8.5,
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Progress Frame Component
class _ProgressFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AllColor.black,
            fontFamily: 'SF Pro Display',
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'October 17,2024',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xB3000000), // rgba(0,0,0,0.7)
                fontFamily: 'SF Pro Display',
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Order : #5555444455',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xB3000000), // rgba(0,0,0,0.7)
                fontFamily: 'SF Pro Display',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Delivery Frame Component
class _DeliveryFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AllColor.black,
            fontFamily: 'SF Pro Display',
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'October 24,2024',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xB3000000), // rgba(0,0,0,0.7)
                fontFamily: 'SF Pro Display',
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Order : #5555444455',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xB3000000), // rgba(0,0,0,0.7)
                fontFamily: 'SF Pro Display',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Review Card Component
class _ReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Overall Rating Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Overall rating',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 20.sp,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AllColor.black,
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Chat Communication Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Chat Communication',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.grey600,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 16.sp,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.grey600,
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Hard Work Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Hard Work',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.grey600,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 16.sp,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.grey600,
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Review Text
          Text(
            'Wow, what a fantastic experience! Your assistance in grasping my vision and translating it accurately was invaluable. Thank you so much! I\'ll definitely be returning for more!',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.black,
              fontFamily: 'sf_pro',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom Section with Button and Home Indicator
class _BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Material(
              color: AllColor.black,
              borderRadius: BorderRadius.circular(99.r),
              child: InkWell(
                onTap: () {
                  // Handle button tap
                },
                borderRadius: BorderRadius.circular(99.r),
                child: Container(
                  width: 382.w,
                  height: 56.h,
                  alignment: Alignment.center,
                  child: Text(
                    'Job delivered',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF5F5F5),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Home Indicator
          Container(
            height: 34.h,
            width: double.infinity,
            alignment: Alignment.center,
            child: Container(
              width: 134.w,
              height: 5.h,
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFF02021D),
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
