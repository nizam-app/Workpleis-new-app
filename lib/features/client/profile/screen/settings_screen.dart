import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'notification_settings_screen.dart';
import 'support_chat_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('2-step verification (coming soon)'),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    _SettingsMenuItem(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      iconColor: const Color(0xFF2D5016),
                      textColor: const Color(0xFF2D5016),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Change Password (coming soon)'),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    _SettingsMenuItem(
                      icon: Icons.person_remove_alt_1_outlined,
                      title: 'Delete Account',
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Delete Account (coming soon)'),
                          ),
                        );
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
            Icon(
              icon,
              size: 24.sp,
              color: iconColor,
            ),
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
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: Color(0xFF002807),
            ),
          ],
        ),
      ),
    );
  }
}
