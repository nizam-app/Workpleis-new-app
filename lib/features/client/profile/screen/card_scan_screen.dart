import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class CardScanScreen extends StatefulWidget {
  const CardScanScreen({super.key});
  static const String routeName = '/card-scan';

  @override
  State<CardScanScreen> createState() => _CardScanScreenState();
}

class _CardScanScreenState extends State<CardScanScreen> {
  void _handleConfirm() {
    // return scanned card data
    context.pop({
      'cardNumber': '5412 7512 3412 3456',
      'expiryDate': '12/23',
      'cardholderName': 'Lee M. Cardholder',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Top Bar ----------
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
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AllColor.grey300, width: 1),
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
                        'CardScan', // ✅ matches design (no space)
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),
            ),

            // ---------- Scanner Area (Fixed) ----------
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 12.h),
                child: LayoutBuilder(
                  builder: (context, c) {
                    // Keep figma ratio 382 x 650
                    const figmaW = 382.0;
                    const figmaH = 650.0;
                    final ratio = figmaW / figmaH;

                    double boxW = c.maxWidth;
                    double boxH = boxW / ratio;

                    if (boxH > c.maxHeight) {
                      boxH = c.maxHeight;
                      boxW = boxH * ratio;
                    }

                    return Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r), // ✅ all corners
                        child: Container(
                          width: boxW,
                          height: boxH,
                          color: const Color(0xFF7F8FA6), // ✅ closer to screenshot
                          child: const _ScanOverlay(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ---------- Confirm Button ----------
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 6.h, 24.w, 20.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.black,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
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
    );
  }
}

class _ScanOverlay extends StatelessWidget {
  const _ScanOverlay();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;

        // Frame size similar to screenshot (center)
        final frameW = w * 0.86;
        final frameH = frameW * 0.58;

        // Highlight rectangle behind card
        final highlightW = frameW * 0.92;
        final highlightH = frameH * 0.78;

        // Card size inside highlight
        final cardW = highlightW * 0.86;
        final cardH = cardW * 0.56;

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // highlight box behind card (darker rectangle)
              Container(
                width: highlightW,
                height: highlightH,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),

              // card
              SizedBox(
                width: cardW,
                height: cardH,
                child: const _CardPreview(),
              ),

              // scan corner brackets + side guide lines (on top)
              SizedBox(
                width: frameW,
                height: frameH,
                child: CustomPaint(
                  painter: _ScanFramePainter(
                    color: Colors.white,
                    stroke: 4.w,
                    corner: 46.w,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  _ScanFramePainter({
    required this.color,
    required this.stroke,
    required this.corner,
  });

  final Color color;
  final double stroke;
  final double corner;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.square;

    final w = size.width;
    final h = size.height;

    // --- corners ---
    // TL
    canvas.drawLine(Offset(0, 0), Offset(corner, 0), p);
    canvas.drawLine(Offset(0, 0), Offset(0, corner), p);

    // TR
    canvas.drawLine(Offset(w - corner, 0), Offset(w, 0), p);
    canvas.drawLine(Offset(w, 0), Offset(w, corner), p);

    // BL
    canvas.drawLine(Offset(0, h), Offset(corner, h), p);
    canvas.drawLine(Offset(0, h - corner), Offset(0, h), p);

    // BR
    canvas.drawLine(Offset(w - corner, h), Offset(w, h), p);
    canvas.drawLine(Offset(w, h - corner), Offset(w, h), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardPreview extends StatelessWidget {
  const _CardPreview();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2E3A4B),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _CardPatternPainter())),

            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // top row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // "world" logo with circular icon
                      Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: AllColor.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'world',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AllColor.white,
                              fontFamily: 'sf_pro',
                            ),
                          ),
                        ],
                      ),
                      Transform.rotate(
                        angle: math.pi / 2,
                        child: Icon(
                          Icons.wifi_rounded,
                          size: 20.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // middle: chip + number in a Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // EMV Chip
                      Container(
                        width: 30.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC9C9C9),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Container(
                            width: 22.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // Card number
                      Expanded(
                        child: Text(
                          '5412 7512 3412 3456',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AllColor.white,
                            fontFamily: 'sf_pro',
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),


                  // bottom row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'VALID THRU',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AllColor.white.withOpacity(0.7),
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '12/23',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AllColor.white.withOpacity(0.9),
                                  fontFamily: 'sf_pro',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Lee M. Cardholder',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AllColor.white.withOpacity(0.95),
                              fontFamily: 'sf_pro',
                            ),
                          ),
                        ],
                      ),

                      // Mastercard (overlap)
                      SizedBox(
                        width: 44.w,
                        height: 22.w,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              child: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEB001B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14.w,
                              child: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF79E1B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Curved arc mark line from bottom-left to upper-right
    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.85);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width * 0.9,
      size.height * 0.15,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
