import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({super.key});

  static const String routeName = '/take-photo';

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
          ),
        );
      }
    }
  }

  Future<void> _takePhotoFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error taking photo: $e'),
          ),
        );
      }
    }
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _handleSave() {
    if (_selectedImage != null) {
      context.pop(_selectedImage);
    } else {
      // If no image selected, return null to indicate deletion or no change
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
                        'Take a Photo',
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Image Display
                    Container(
                      width: 300.w,
                      height: 300.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF99FF00), // Vibrant lime green
                      ),
                      child: ClipOval(
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/ac_profile_image.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF99FF00),
                                    child: Icon(
                                      Icons.person,
                                      size: 100.sp,
                                      color: AllColor.white,
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),

                    //SizedBox(height: 40.h),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        // Upload/Gallery Button (Image 1)
                        GestureDetector(
                          onTap: () async {
                            // Show bottom sheet to choose camera or gallery
                            final source = await showModalBottomSheet<ImageSource>(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color: AllColor.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                ),
                                child: SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.camera_alt),
                                        title: Text('Take Photo'),
                                        onTap: () => Navigator.pop(context, ImageSource.camera),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.photo_library),
                                        title: Text('Choose from Gallery'),
                                        onTap: () => Navigator.pop(context, ImageSource.gallery),
                                      ),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),
                                ),
                              ),
                            );
                            if (source != null) {
                              if (source == ImageSource.camera) {
                                await _takePhotoFromCamera();
                              } else {
                                await _pickImageFromGallery();
                              }
                            }
                          },
                          child: Container(
                            width: 56.w,
                            height: 56.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50), // Standard green
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AllColor.white,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.photo_library,
                              size: 24.sp,
                              color: AllColor.white,
                            ),
                          ),
                        ),

                        SizedBox(width: 24.w),

                        // Delete Button (Image 2)
                        GestureDetector(
                          onTap: _selectedImage != null ? _deleteImage : null,
                          child: Container(
                            width: 56.w,
                            height: 56.w,
                            decoration: BoxDecoration(
                              color: _selectedImage != null
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AllColor.white,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              size: 24.sp,
                              color: AllColor.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
