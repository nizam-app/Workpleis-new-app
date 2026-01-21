import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_settings_screen.dart';
import 'support_chat_screen.dart';
import 'two_step_verification_screen.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showDeleteAccountDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Delete Account',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            //Full screen blurred background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
            // Dialog content centered
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
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Are you sure?',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Body text
                    Text(
                      'If you delete your account you will lose all your saved date and preferecnes',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        height: 1.5,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Buttons
                    Row(
                      children: [
                        // Cancel Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E0E0), // Light gray
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AllColor.black,
                                    fontFamily: 'sf_pro',
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Delete Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              // Clear all stored preferences
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();

                              // Close dialog
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }

                              // Navigate to Login screen
                              if (context.mounted) {
                                context.go(LoginScreen.routeName);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF4D4D), // Red
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AllColor.white,
                                    fontFamily: 'sf_pro',
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
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
                        'Settings',
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

            SizedBox(height: 24.h),

            // SETTINGS Section
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SETTINGS',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.grey600,
                        fontFamily: 'sf_pro',
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _SettingsMenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notification Settings',
                      iconColor: const Color(0xFF2D5016),
                      textColor: const Color(0xFF2D5016),
                      onTap: () {
                        context.push(NotificationSettingsScreen.routeName);
                      },
                    ),
                    SizedBox(height: 12.h),
                    _SettingsMenuItem(
                      icon: Icons.help_outline,
                      title: 'Support',
                      iconColor: const Color(0xFF2D5016),
                      textColor: const Color(0xFF2D5016),
                      onTap: () {
                        context.push(SupportChatScreen.routeName);
                      },
                    ),
                    SizedBox(height: 12.h),
                    _SettingsMenuItem(
                      icon: Icons.verified_user_outlined,
                      title: '2-step verification',
                      iconColor: const Color(0xFF2D5016),
                      textColor: const Color(0xFF2D5016),
                      onTap: () {
                        context.push(TwoStepVerificationScreen.routeName);
                      },
                    ),
                    SizedBox(height: 12.h),
                    _SettingsMenuItem(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      iconColor: const Color(0xFF2D5016),
                      textColor: const Color(0xFF2D5016),
                      onTap: () {
                        context.push(ChangePasswordScreen.routeName);
                      },
                    ),
                    SizedBox(height: 12.h),
                    _SettingsMenuItem(
                      icon: Icons.person_remove_alt_1_outlined,
                      title: 'Delete Account',
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      onTap: () {
                        _showDeleteAccountDialog();
                      },
                    ),
                    SizedBox(height: 40.h),
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

class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onTap;

  const _SettingsMenuItem({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: iconColor),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  fontFamily: 'sf_pro',
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 20.sp, color: Color(0xFF002807)),
          ],
        ),
      ),
    );
  }
}
