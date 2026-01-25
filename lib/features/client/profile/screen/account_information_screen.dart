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
  final TextEditingController _aboutMeController = TextEditingController(
    text:
        'Intuitive Consumer Experience and Digital Transformation Agency.\nSchedule a call in Calendly or email us at sadax.studio@gmail.com\n\nCapabilities:\n• Discovery Sessions (UX Research)\n• Desk Research\n• Market Research\n• Discovery Mapping\n• User Interviews\n• Usability Testing\n\nUX/UI\n• Websites\n• Web Apps\n• Mobile Apps',
  );

  bool _isOnlineStatusEnabled = true;
  File? _profileImage;

  final List<String> _skills = [
    'Assembly',
    'Mounting',
    'Moving',
    'Cleaning',
    'Outdoor Help',
    'Home Rrepairs',
    'Painting',
    'Trending',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryCodeController.dispose();
    _phoneNumberController.dispose();
    _aboutMeController.dispose();
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

  void _handleEditBio(String section) {
    // Handle edit bio logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit $section (coming soon)'),
      ),
    );
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
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
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
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AllColor.bgcolor, // Lime green #CAFF45
                                width: 4,
                              ),
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
                                          color: const Color(0xFFE0E0E0),
                                          child: Icon(
                                            Icons.person,
                                            size: 60.sp,
                                            color: AllColor.grey600,
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
                            child: GestureDetector(
                              onTap: _pickProfileImage,
                              child: Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: AllColor.switchcolor, // Lime green
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
                          // Online Status Icon (Target/Bullseye)
                          CustomPaint(
                            size: Size(40.w, 40.w),
                            painter: _TargetIconPainter(),
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
                                  "You'll remain Online for as long as the is open.",
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
                            activeTrackColor: AllColor.switchcolor, // Lime green
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
                            fontWeight: FontWeight.w400,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: AllColor.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                              width: 1,
                            ),
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
                            fontWeight: FontWeight.w400,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: AllColor.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                              width: 1,
                            ),
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
                            fontWeight: FontWeight.w400,
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
                                  color: AllColor.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: const Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 12.w),
                                    // Saudi Arabia flag icon
                                    Container(
                                      width: 24.w,
                                    height: 16.h,
                                      decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Image.asset(
                                        'assets/images/flag.png',
                                        width: 24.w,

                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: const Color(0xFF4CAF50),
                                            child: Icon(
                                              Icons.flag,
                                              size: 16.sp,
                                              color: AllColor.white,
                                            ),
                                          );
                                        },
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
                                  color: AllColor.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: const Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
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

                    SizedBox(height: 32.h),

                    // About me Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'About me',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AllColor.black,
                                fontFamily: 'sf_pro',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _handleEditBio('About me'),
                              child: Text(
                                'Edit Bio',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF171717), // Blue/purple
                                  fontFamily: 'sf_pro',
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 200.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AllColor.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _aboutMeController,
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AllColor.black,
                              fontFamily: 'sf_pro',
                              height: 1.4,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Skills Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Skills',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AllColor.black,
                                fontFamily: 'sf_pro',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _handleEditBio('Skills'),
                              child: Text(
                                'Edit Bio',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF171717), // Blue/purple
                                  fontFamily: 'sf_pro',
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: _skills.map((skill) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F8F8), // Light grey
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    skill,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AllColor.black,
                                      fontFamily: 'sf_pro',
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.add,
                                    size: 14.sp,
                                    color: AllColor.black,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),
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

// Custom painter for target/bullseye icon
class _TargetIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF002807);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF002807);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Draw outer circle
    canvas.drawCircle(center, radius, paint);

    // Draw inner filled circle
    canvas.drawCircle(center, radius * 0.4, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
