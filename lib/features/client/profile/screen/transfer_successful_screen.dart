import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'profile_screen.dart';

class TransferSuccessfulScreen extends StatefulWidget {
  const TransferSuccessfulScreen({super.key});

  static const String routeName = '/transfer-successful';

  @override
  State<TransferSuccessfulScreen> createState() =>
      _TransferSuccessfulScreenState();
}

class _TransferSuccessfulScreenState extends State<TransferSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Column(
          children: [
            // Close Button (Top Left)
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
                        color: AllColor.white,
                       borderRadius: BorderRadius.circular(10),
                       // shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 1,
                        ),
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

            // Main Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Illustration
                  Container(
                    width: 300.w,
                   // height: 500.w,
                    // decoration: BoxDecoration(
                    //  color: const Color(0xFF76C11F), // Bright green
                    //   borderRadius: BorderRadius.circular(30.r),
                    // ),
                    child: Image.asset(
                      'assets/images/payment.png',
                    ),

                  ),

                   SizedBox(height: 20.h),

                  // Headline Text
                  Text(
                    'Transfer successful',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AllColor.black,
                      fontFamily: 'sf_pro',
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Sub-headline Text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.w),
                    child: Text(
                      'Thank you for your Payment. We will be in contact with more details shortly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Done Button
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to ProfileScreen
                          context.go(ProfileScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AllColor.black,
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AllColor.white,
                            fontFamily: 'sf_pro',
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
                        margin: EdgeInsets.only(top: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF02021D),
                          borderRadius: BorderRadius.circular(100.r),
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
