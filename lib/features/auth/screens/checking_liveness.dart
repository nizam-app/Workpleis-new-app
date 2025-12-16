import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/auth/screens/account_successful.dart';

import '../../../core/constants/color_control/all_color.dart';

class CheckingLiveness extends StatefulWidget {
  const CheckingLiveness({super.key});

  static const String routeName = '/checking-liveness';

  @override
  State<CheckingLiveness> createState() => _CheckingLivenessState();
}

class _CheckingLivenessState extends State<CheckingLiveness>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // ✅ 3 sec
    );

    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward(); // ✅ start loading once

    // ✅ 3 seconds পরে auto next (close this page)
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.push(AccountSuccessful.routeName);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFCAFF45);

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              const Spacer(),

              /// ✅ Neon check circle (same-to-same)
              const _NeonCheckBadge(neon: neon),

              SizedBox(height: 18.h),

              Text(
                "Checking liveness...",
                style: TextStyle(
                  fontFamily: 'sf_pro',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: AllColor.black,
                ),
              ),

              SizedBox(height: 12.h),

              /// ✅ Progress bar (0 -> 100% in 3 sec)
              AnimatedBuilder(
                animation: _anim,
                builder: (context, _) => _ProgressBar(value: _anim.value),
              ),

              SizedBox(height: 220.h),

              /// ✅ Workpleis logo
              Image.asset(
                "assets/images/updatelogo.png",
                width: 162.w,
                fit: BoxFit.contain,
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeonCheckBadge extends StatelessWidget {
  const _NeonCheckBadge({required this.neon});

  final Color neon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: neon.withOpacity(0.30),
            ),
          ),
          Container(
            width: 86.w,
            height: 86.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: neon.withOpacity(0.60),
            ),
          ),
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: neon,
            ),
          ),
          Icon(
            Icons.check,
            size: 24.sp,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value; // 0..1

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        height: 8.h,
        width: double.infinity,
        color: const Color(0xFFE6E6E6),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: v,
          child: Container(color: Colors.black),
        ),
      ),
    );
  }
}
