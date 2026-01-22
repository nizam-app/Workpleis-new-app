import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class MarkCompletedScreen extends StatefulWidget {
  const MarkCompletedScreen({
    super.key,
    this.peerName = 'Kazi Mahbub',
    this.isOnline = true,
    this.peerAvatarAsset = 'assets/images/profile.png',
    this.title =
        'I have two tickets for the Al-Nassr  Paris match for sale design',
    this.quote = '8 Sec',
    this.price = r'$600',
    this.location = 'Jaddah',
    this.categories = const ['Design', 'Banner Design'],
  });

  static const String routeName = '/mark-completed';

  final String peerName;
  final bool isOnline;
  final String peerAvatarAsset;
  final String title;
  final String quote;
  final String price;
  final String location;
  final List<String> categories;

  @override
  State<MarkCompletedScreen> createState() => _MarkCompletedScreenState();
}

class _MarkCompletedScreenState extends State<MarkCompletedScreen> {
  final TextEditingController _blockReasonController = TextEditingController();

  bool _showMenu = false;
  bool _showBlockUserDialog = false;
  bool _showBlockConfirmationDialog = false;
  bool _isUserBlocked = false;

  @override
  void dispose() {
    _blockReasonController.dispose();
    super.dispose();
  }

  void _openBlockUserDialog() {
    setState(() {
      _showMenu = false;
      _showBlockUserDialog = true;
    });
  }

  void _hideBlockUserDialog() {
    setState(() {
      _showBlockUserDialog = false;
      _blockReasonController.clear();
    });
  }

  void _sendBlockRequest() {
    setState(() {
      _showBlockUserDialog = false;
      _showBlockConfirmationDialog = true;
    });
  }

  void _hideBlockConfirmationDialog() {
    setState(() {
      _showBlockConfirmationDialog = false;
    });
  }

  void _confirmBlockUser() {
    final reason = _blockReasonController.text.trim();
    setState(() {
      _isUserBlocked = true;
      _showBlockConfirmationDialog = false;
      _blockReasonController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User blocked${reason.isNotEmpty ? ': $reason' : ''}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: GestureDetector(
        onTap: () {
          if (_showMenu) {
            setState(() {
              _showMenu = false;
            });
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Column(
                children: [
                  // App Bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Icon(
                            Icons.arrow_back,
                            size: 24.sp,
                            color: AllColor.black,
                          ),
                        ),
                        // Title
                        Text(
                          'Mark Completed',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AllColor.black,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                        // Three-dot Menu with Block User option
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showMenu = !_showMenu;
                                });
                              },
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: AllColor.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: const Color(0xFFD0D0D0),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.more_vert,
                                  size: 20.sp,
                                  color: AllColor.black,
                                ),
                              ),
                            ),
                            if (_showMenu)
                              Positioned(
                                right: 0,
                                top: 45.h,
                                child: Container(
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    color: AllColor.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {}, // Prevent parent tap
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: _openBlockUserDialog,
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                              vertical: 12.h,
                                            ),
                                            child: Text(
                                              'Block User',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red,
                                                fontFamily: 'sf_pro',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Main Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Section
                            Row(
                              children: [
                                // Profile Picture
                                Container(
                                  width: 50.w,
                                  height: 50.w,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF8EC800,
                                    ), // Light green
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      widget.peerAvatarAsset,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: const Color(0xFF8EC800),
                                              child: Icon(
                                                Icons.person,
                                                size: 24.sp,
                                                color: AllColor.white,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                // Name and Status
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.peerName,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AllColor.black,
                                          fontFamily: 'sf_pro',
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        widget.isOnline ? 'Online' : 'Offline',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF696969),
                                          fontFamily: 'sf_pro',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Three-dot Menu (in profile section - can be removed or kept for consistency)
                                SizedBox(width: 24.w), // Spacer instead of menu
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // Job Description
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AllColor.black,
                                fontFamily: 'sf_pro',
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Job Details Cards (Quote, Price, Location)
                            Row(
                              children: [
                                Expanded(
                                  child: _InfoCard(
                                    label: 'Quote',
                                    value: widget.quote,
                                  ),
                                ),
                                SizedBox(width: 9.w),
                                Expanded(
                                  child: _InfoCard(
                                    label: 'Price',
                                    value: widget.price,
                                  ),
                                ),
                                SizedBox(width: 9.w),
                                Expanded(
                                  child: _InfoCard(
                                    label: 'Location',
                                    value: widget.location,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // Services Section
                            Text(
                              'SERVICES',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7D7D7D),
                                fontFamily: 'sf_pro',
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 9.h),
                            Wrap(
                              spacing: 4.w,
                              runSpacing: 4.h,
                              children: widget.categories
                                  .map((c) => _CategoryChip(label: c))
                                  .toList(),
                            ),

                            SizedBox(height: 24.h),

                            // Message Button
                            SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: ElevatedButton(
                                onPressed: _isUserBlocked
                                    ? null
                                    : () {
                                        // Navigate to message/chat screen
                                        context.push(
                                          '/chat',
                                          extra: <String, dynamic>{
                                            'peerName': widget.peerName,
                                            'isOnline': widget.isOnline,
                                            'peerAvatarAsset':
                                                widget.peerAvatarAsset,
                                          },
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isUserBlocked
                                      ? const Color(0xFFCCCCCC)
                                      : AllColor.black,
                                  foregroundColor: AllColor.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(99.r),
                                  ),
                                ),
                                child: Text(
                                  _isUserBlocked ? 'User Blocked' : 'Message',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AllColor.white,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Block User Dialog
            if (_showBlockUserDialog)
              Positioned.fill(
                child: _BlockUserDialog(
                  controller: _blockReasonController,
                  onClose: _hideBlockUserDialog,
                  onSend: _sendBlockRequest,
                ),
              ),
            // Block Confirmation Dialog
            if (_showBlockConfirmationDialog)
              Positioned.fill(
                child: _BlockConfirmationDialog(
                  onClose: _hideBlockConfirmationDialog,
                  onConfirm: _confirmBlockUser,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Info Card Widget (Quote, Price, Location)
class _InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF1), // Very light green
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE1E8D2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0x6B000000), // rgba(0,0,0,0.42)
              fontFamily: 'sf_pro',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AllColor.black,
              fontFamily: 'sf_pro',
            ),
          ),
        ],
      ),
    );
  }
}

// Category Chip Widget
class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFDDDDDD), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: AllColor.black,
          fontFamily: 'sf_pro',
          height: 1.0,
        ),
      ),
    );
  }
}

// Block User Dialog
class _BlockUserDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClose;
  final VoidCallback onSend;

  const _BlockUserDialog({
    required this.controller,
    required this.onClose,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background overlay
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: GestureDetector(
                onTap: onClose,
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
        ),
        // Dialog content
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Close Button
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Block User',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                      GestureDetector(
                        onTap: onClose,
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            shape: BoxShape.circle,
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
                // Text Input Area
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 120.h,
                      maxHeight: 200.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.all(16.w),
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      minLines: 4,
                      textInputAction: TextInputAction.newline,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText:
                            'This is client spam. The Tasker app is looking quite bad.',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.grey600,
                          fontFamily: 'sf_pro',
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ),
                ),
                // Sent Button
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: GestureDetector(
                    onTap: onSend,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AllColor.black,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Sent',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
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
        ),
      ],
    );
  }
}

// Block Confirmation Dialog (Second Popup)
class _BlockConfirmationDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onConfirm;

  const _BlockConfirmationDialog({
    required this.onClose,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background overlay
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: GestureDetector(
                onTap: onClose,
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
        ),
        // Dialog content
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Close Button
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Block User',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                      GestureDetector(
                        onTap: onClose,
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            shape: BoxShape.circle,
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
                // Message Text
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: Text(
                    'User will be blocked.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.black,
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ),
                // Confirm Button
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AllColor.black,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
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
        ),
      ],
    );
  }
}
