import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'account_information_screen.dart';
import 'billing_payment_screen.dart';
import 'order_management_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey/off-white background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Title and Logout Icon
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w700,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                        height: 1.1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle logout
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logout (coming soon)'),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Profile Banner with Green Background
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA8FF3F), // Vibrant lime green
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      // Profile Image with Checkmark
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 64.w,
                            height: 64.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/ac_profile_image.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AllColor.grey200,
                                    child: Icon(
                                      Icons.person,
                                      size: 32.sp,
                                      color: AllColor.grey600,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Blue checkmark badge
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                size: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(width: 16.w),
                      
                      // Name and Role
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ramjan Ahmed',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A), // Dark blue/black
                                fontFamily: 'sf_pro',
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Client',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AllColor.grey600, // Light grey
                                fontFamily: 'sf_pro',
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Rate Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Rate: 55%',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // ACCOUNT Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACCOUNT',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.grey600,
                        fontFamily: 'sf_pro',
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _ProfileMenuItem(
                      icon: Icons.person_outline,
                      title: 'Account Information',
                      onTap: () {
                        context.push(AccountInformationScreen.routeName);
                      },
                    ),
                    SizedBox(height: 12.h),
                    _ProfileMenuItem(
                      icon: Icons.credit_card_outlined,
                      title: 'Billing Payment',
                      onTap: () {
                        context.push(BillingPaymentScreen.routeName);
                      },
                    ),
                    SizedBox(height: 12.h),
                    _ProfileMenuItem(
                      icon: Icons.inventory_2_outlined,
                      title: 'Order Management',
                      onTap: () {
                        context.push(OrderManagementScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // CHANGE LANGUAGE Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHANGE LANGUAGE',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.grey600,
                        fontFamily: 'sf_pro',
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _LanguageSelector(
                      language: 'English',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Language selector (coming soon)'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // SETTINGS Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SETTINGS',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.grey600,
                        fontFamily: 'sf_pro',
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _ProfileMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        context.push(SettingsScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // Terms & Condition and Privacy Policy Links
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Terms & Condition (coming soon)'),
                          ),
                        );
                      },
                      child: Text(
                        'Terms & Condition',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2D5016), // Dark green/teal
                          fontFamily: 'sf_pro',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      ' & ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF2D5016),
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Privacy Policy (coming soon)'),
                          ),
                        );
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2D5016), // Dark green/teal
                          fontFamily: 'sf_pro',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
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
              color: const Color(0xFF2D5016), // Dark green
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2D5016), // Dark green
                  fontFamily: 'sf_pro',
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: AllColor.grey300, // Light grey chevron
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  final String language;
  final VoidCallback onTap;

  const _LanguageSelector({
    required this.language,
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
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: const Color(0xFF2D5016), // Dark green
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 14.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2D5016), // Dark green
                  fontFamily: 'sf_pro',
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 24.sp,
              color: AllColor.grey300, // Light grey dropdown icon
            ),
          ],
        ),
      ),
    );
  }
}
