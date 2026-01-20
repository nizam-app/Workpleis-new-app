import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  static const String routeName = '/notification-settings';

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _changePasswordSecurity = true;
  bool _strictlyNecessaryCookies = true;
  bool _performanceCookies = true;
  bool _functionalCookies = false;
  bool _targetingCookies = true;

  void _handleConfirm() {
    // Handle confirm logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification settings saved successfully'),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6), // Light grey/off-white background
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
                        Icons.arrow_back_ios_new,
                        size: 18.sp,
                        color: AllColor.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Notification Setting',
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
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  children: [
                    // Setting 1: Change Password Security
                    _NotificationSettingItem(
                      title: 'Change Password Security',
                      description:
                          'Persona information click "reject all" below. we and selected thir parties use cookies or similar t...',
                      value: _changePasswordSecurity,
                      onChanged: (value) {
                        setState(() {
                          _changePasswordSecurity = value;
                        });
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Setting 2: Strictly Necessary Cookies
                    _NotificationSettingItem(
                      title: 'Strictly Necessary Cookies',
                      description:
                          'These cookies are essential for users to browse or use our website and its features. Such as accessing s',
                      value: _strictlyNecessaryCookies,
                      onChanged: (value) {
                        setState(() {
                          _strictlyNecessaryCookies = value;
                        });
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Setting 3: Performance Cookies
                    _NotificationSettingItem(
                      title: 'Performance Coookies',
                      description:
                          'These cookies allow us to count visits in traffic sources so we can measure and improve the per...',
                      value: _performanceCookies,
                      onChanged: (value) {
                        setState(() {
                          _performanceCookies = value;
                        });
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Setting 4: Functional Cookies
                    _NotificationSettingItem(
                      title: 'Functional Cookies',
                      description:
                          'These cookies enable the website to provide enhanced functionality and personalisation. The...',
                      value: _functionalCookies,
                      onChanged: (value) {
                        setState(() {
                          _functionalCookies = value;
                        });
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Setting 5: Targeting Cookies
                    _NotificationSettingItem(
                      title: 'Targeting Cookies',
                      description:
                          'These cookies track users\' online activity to help advertisers deliver more relevant advertising.',
                      value: _targetingCookies,
                      onChanged: (value) {
                        setState(() {
                          _targetingCookies = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Button
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 20.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.black,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm my choices',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
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

class _NotificationSettingItem extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationSettingItem({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.grey600,
                    fontFamily: 'sf_pro',
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Switch(
            value: value,
            onChanged: onChanged,
            // Lime green
            activeTrackColor: const Color(0xFF87B70F), // Lime green
            inactiveThumbColor: const Color(0xFFFFFFFF),
            inactiveTrackColor: AllColor.grey300,
            activeThumbColor: const Color(0xFFFFFFFF),

          ),
        ],
      ),
    );
  }
}
