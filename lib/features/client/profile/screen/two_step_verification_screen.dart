import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class TwoStepVerificationScreen extends StatefulWidget {
  const TwoStepVerificationScreen({super.key});

  static const String routeName = '/two-step-verification';

  @override
  State<TwoStepVerificationScreen> createState() =>
      _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
  String _pin = '';

  void _onNumberPressed(String number) {
    if (_pin.length < 4) {
      setState(() {
        _pin += number;
      });
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _handleContinue() {
    if (_pin.length == 4) {
      // TODO: Handle PIN verification/saving logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN set successfully'),
        ),
      );
      context.pop();
    }
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
                          color: AllColor.grey300,
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
                        '2-step verification',
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

            // Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),

                    // "Set PIN" Title
                    Text(
                      'Set PIN',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Instructional Text
                    Text(
                      'After 10 min of inactivity, the app will lock. to unlock enter',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.grey600,
                        fontFamily: 'sf_pro',
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'PIN or login again.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.grey600,
                        fontFamily: 'sf_pro',
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // "Choose a new PIN" Prompt
                    Text(
                      'Choose a new PIN',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // PIN Input Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(4, (index) {
                        final isFilled = index < _pin.length;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          width: 16.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFilled
                                ? const Color(0xFF99FF00) // Lime green
                                : AllColor.white,
                            border: Border.all(
                              color: isFilled
                                  ? const Color(0xFF99FF00)
                                  : AllColor.black,
                              width: 1.5,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 80.h),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _pin.length == 4 ? _handleContinue : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AllColor.black,
                          disabledBackgroundColor: AllColor.grey300,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AllColor.white,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Numerical Keypad
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.h),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    // Row 1: 1, 2, 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _KeypadButton(
                          label: '1',
                          onPressed: () => _onNumberPressed('1'),
                        ),
                        _KeypadButton(
                          label: '2',
                          onPressed: () => _onNumberPressed('2'),
                        ),
                        _KeypadButton(
                          label: '3',
                          onPressed: () => _onNumberPressed('3'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Row 2: 4, 5, 6
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _KeypadButton(
                          label: '4',
                          onPressed: () => _onNumberPressed('4'),
                        ),
                        _KeypadButton(
                          label: '5',
                          onPressed: () => _onNumberPressed('5'),
                        ),
                        _KeypadButton(
                          label: '6',
                          onPressed: () => _onNumberPressed('6'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Row 3: 7, 8, 9
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _KeypadButton(
                          label: '7',
                          onPressed: () => _onNumberPressed('7'),
                        ),
                        _KeypadButton(
                          label: '8',
                          onPressed: () => _onNumberPressed('8'),
                        ),
                        _KeypadButton(
                          label: '9',
                          onPressed: () => _onNumberPressed('9'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Row 4: 0 (centered), Backspace (right)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 80.w), // Left spacer
                        _KeypadButton(
                          label: '0',
                          onPressed: () => _onNumberPressed('0'),
                        ),
                        _KeypadButton(
                          label: '',
                          icon: Icons.backspace_outlined,
                          onPressed: _onBackspacePressed,
                        ),
                      ],
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

class _KeypadButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  const _KeypadButton({
    required this.label,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80.w,
        height: 56.h,
        alignment: Alignment.center,
        child: icon != null
            ? Icon(
                icon,
                size: 24.sp,
                color: AllColor.black,
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),
      ),
    );
  }
}
