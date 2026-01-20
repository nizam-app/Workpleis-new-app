import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'take_photo_screen.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  static const String routeName = '/account-information';

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final TextEditingController _firstNameController =
      TextEditingController(text: 'Ramjan');
  final TextEditingController _lastNameController =
      TextEditingController(text: 'Ahmed');
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+966');
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '75476-013');

  bool _isOnlineStatusEnabled = true;
  File? _profileImage;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryCodeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final result = await context.push(TakePhotoScreen.routeName);
    if (result != null && result is File) {
      setState(() {
        _profileImage = result;
      });
    }
  }

  void _handleSave() {
    // Handle save logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account information saved successfully'),
      ),
    );
    context.pop();
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
                        borderRadius: BorderRadius.circular(10.r),
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
                        'Account Information',
                        style: TextStyle(
                          fontSize: 20.sp,
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

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 32.h),

                    // Profile Picture Section
                    GestureDetector(
                      onTap: _pickProfileImage,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //   color: const Color(0xFFA8FF3F), // Lime green
                              //   width: 4,
                              // ),
                            ),
                            child: ClipOval(
                              child: _profileImage != null
                                  ? Image.file(
                                      _profileImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/ac_profile_image.png',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: const Color(0xFFA8FF3F),
                                          child: Icon(
                                            Icons.person,
                                            size: 60.sp,
                                            color: AllColor.white,
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                          // Edit button overlay
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFA8FF3F), // Lime green
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AllColor.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 18.sp,
                                color: AllColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Online Status Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8), // Light grey
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          // Online Status Icon
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AllColor.black, // Lime green
                                width: 2,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: AllColor.black, // Lime green
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Online Status',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AllColor.black,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "You'll remain Online for as long as the is open",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AllColor.grey600,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _isOnlineStatusEnabled,
                            onChanged: (value) {
                              setState(() {
                                _isOnlineStatusEnabled = value;
                              });
                            },
                            activeColor: AllColor.white,
                            activeTrackColor: const Color(0xFFA8FF3F), // Lime green
                            inactiveThumbColor: AllColor.white,
                            inactiveTrackColor: AllColor.grey300,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // First Name Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8), // Light grey
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: TextField(
                            controller: _firstNameController,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AllColor.black,
                              fontFamily: 'sf_pro',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Last Name Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8), // Light grey
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: TextField(
                            controller: _lastNameController,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AllColor.black,
                              fontFamily: 'sf_pro',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Number Field (Country Code + Phone Number)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Number',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            // Country Code Field
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 56.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8F8F8), // Light grey
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 12.w),
                                    // Saudi Arabia flag placeholder (you can replace with actual flag image)
                                    Container(
                                      width: 24.w,
                                      height: 24.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AllColor.grey300,
                                      ),
                                      child: Icon(
                                        Icons.flag,
                                        size: 16.sp,
                                        color: AllColor.grey600,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: TextField(
                                        controller: _countryCodeController,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AllColor.black,
                                          fontFamily: 'sf_pro',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Phone Number Field
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 56.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8F8F8), // Light grey
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: TextField(
                                  controller: _phoneNumberController,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AllColor.black,
                                    fontFamily: 'sf_pro',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 16.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Save Button
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.black,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18.sp,
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
