import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ServiceOrderManagementScreen extends StatefulWidget {
  const ServiceOrderManagementScreen({super.key});

  static const String routeName = '/service-order-management';

  @override
  State<ServiceOrderManagementScreen> createState() =>
      _ServiceOrderManagementScreenState();
}

class _ServiceOrderManagementScreenState
    extends State<ServiceOrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final List<_AttachedFile> _attachedFiles = [
    _AttachedFile(
      id: 1,
      name: 'file1.png',
      bytes: null,
      isImage: true,
    ),
    _AttachedFile(
      id: 2,
      name: 'file2.png',
      bytes: null,
      isImage: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickAttachments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
    );
    if (result == null || result.files.isEmpty) return;

    setState(() {
      for (final file in result.files) {
        final ext = (file.extension ?? '').toLowerCase();
        if (['pdf', 'png', 'jpg', 'jpeg'].contains(ext) &&
            file.size <= 10 * 1024 * 1024) {
          _attachedFiles.add(
            _AttachedFile(
              id: _attachedFiles.length + 1,
              name: file.name,
              bytes: file.bytes,
              isImage: ['png', 'jpg', 'jpeg'].contains(ext),
            ),
          );
        }
      }
    });
  }

  void _removeFile(int id) {
    setState(() {
      _attachedFiles.removeWhere((f) => f.id == id);
    });
  }

  void _markAsCompleted() {
    // Navigate to Mark Completed screen
    context.push('/mark-completed', extra: <String, dynamic>{
      'peerName': 'Kazi Mahbub',
      'isOnline': true,
      'peerAvatarAsset': 'assets/images/profile.png',
      'title': 'I have two tickets for the Al-Nassr  Paris match for sale design',
      'quote': '8 Sec',
      'price': r'$600',
      'location': 'Jaddah',
      'categories': const ['Design', 'Banner Design'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                children: [
                  // Back Button - Circular, light grey
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        shape: BoxShape.circle,
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
                        'Order Management',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
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

            // Tab Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  // Order History Tab
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() => _selectedTabIndex = 0);
                        _tabController.animateTo(0);
                      },
                      child: Column(
                        children: [
                          Text(
                            'Order History',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: _selectedTabIndex == 0
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: _selectedTabIndex == 0
                                  ? AllColor.black
                                  : const Color(0xFF696969),
                              fontFamily: 'sf_pro',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          if (_selectedTabIndex == 0)
                            Container(
                              height: 2.h,
                              decoration: BoxDecoration(
                                color: AllColor.black,
                                borderRadius: BorderRadius.circular(1.r),
                              ),
                            )
                          else
                            SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  // Transaction Tab
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() => _selectedTabIndex = 1);
                        _tabController.animateTo(1);
                      },
                      child: Column(
                        children: [
                          Text(
                            'Transaction',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: _selectedTabIndex == 1
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: _selectedTabIndex == 1
                                  ? AllColor.black
                                  : const Color(0xFF696969),
                              fontFamily: 'sf_pro',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          if (_selectedTabIndex == 1)
                            Container(
                              height: 2.h,
                              decoration: BoxDecoration(
                                color: AllColor.black,
                                borderRadius: BorderRadius.circular(1.r),
                              ),
                            )
                          else
                            SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Tab Content
            Expanded(
              child: Stack(
                children: [
                  TabBarView(
                    controller: _tabController,
                    children: [
                      _OrderHistoryTab(
                        attachedFiles: _attachedFiles,
                        onPickAttachments: _pickAttachments,
                        onRemoveFile: _removeFile,
                      ),
                      const _TransactionTab(),
                    ],
                  ),
                  // Bottom Button (only show on Order History tab)
                  if (_selectedTabIndex == 0)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _BottomActionSection(
                        onMarkAsCompleted: _markAsCompleted,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Order History Tab
class _OrderHistoryTab extends StatelessWidget {
  final List<_AttachedFile> attachedFiles;
  final VoidCallback onPickAttachments;
  final Function(int) onRemoveFile;

  const _OrderHistoryTab({
    required this.attachedFiles,
    required this.onPickAttachments,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 140.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          // Message Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Kazi',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'I am ready to send you the file. Please review it and let me know if you approve it.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Feel free to let me know if you need any more adjustments!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Attach file Section
          Text(
            'Attach file',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.black,
              fontFamily: 'sf_pro',
            ),
          ),
          SizedBox(height: 12.h),

          // Attach File Input Box
          InkWell(
            onTap: onPickAttachments,
            borderRadius: BorderRadius.circular(8.r),
            child: _DashedRoundedBorder(
              radius: 8.r,
              dashWidth: 6.w,
              dashGap: 4.w,
              strokeWidth: 1.2,
              color: const Color(0xFF827373),
              child: Container(
                height: 73.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AllColor.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Container(
                      width: 31.w,
                      height: 31.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7A58E1), // Purple
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.attach_file,
                        color: AllColor.white,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attach file',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF111111),
                              fontFamily: 'sf_pro',
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'pdf, png, jpeg and max 10mb',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0x8C808080),
                              fontFamily: 'sf_pro',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Attached File Previews
          if (attachedFiles.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: attachedFiles.map((file) {
                return _FilePreview(
                  file: file,
                  onRemove: () => onRemoveFile(file.id),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

// File Preview Widget
class _FilePreview extends StatelessWidget {
  final _AttachedFile file;
  final VoidCallback onRemove;

  const _FilePreview({
    required this.file,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: file.isImage && file.bytes != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.memory(
              file.bytes!,
              width: 100.w,
              height: 100.w,
              fit: BoxFit.cover,
            ),
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              'assets/images/card.png', // replace with your actual file name
              width: 100.w,
              height: 100.w,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: 4.h,
          right: 4.w,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                  shape: BoxShape.circle,// Purple
              border: Border.all(width: 2.w,color: Color(0xFF7741FB))
              ),
              child: Icon(
                Icons.close,
                size: 14.sp,
                color: AllColor.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Attached File Model
class _AttachedFile {
  final int id;
  final String name;
  final Uint8List? bytes;
  final bool isImage;

  _AttachedFile({
    required this.id,
    required this.name,
    this.bytes,
    required this.isImage,
  });
}

// Bottom Action Section
class _BottomActionSection extends StatelessWidget {
  final VoidCallback onMarkAsCompleted;

  const _BottomActionSection({required this.onMarkAsCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AllColor.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mark as Completed Button
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 12.h),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: onMarkAsCompleted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AllColor.black,
                    foregroundColor: const Color(0xFFF5F5F5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                  ),
                  child: Text(
                    'Mark as a Completed',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF5F5F5),
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ),
              ),
            ),
            // Home Indicator
            Container(
              height: 34.h,
              width: double.infinity,
              alignment: Alignment.center,
              child: Container(
                width: 134.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF02021D),
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Transaction Tab
class _TransactionTab extends StatelessWidget {
  const _TransactionTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Section
          Row(
            children: [
              Text(
                'Balance :',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '500 SAR',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF87B70F),
                  fontFamily: 'sf_pro',
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Add transaction content here
        ],
      ),
    );
  }
}

// Dashed Border Widget
class _DashedRoundedBorder extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  const _DashedRoundedBorder({
    required this.child,
    required this.radius,
    required this.color,
    this.strokeWidth = 1,
    this.dashWidth = 6,
    this.dashGap = 4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRRectPainter(
        radius: radius,
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashGap: dashGap,
      ),
      child: child,
    );
  }
}

// Dashed Border Painter
class _DashedRRectPainter extends CustomPainter {
  final double radius;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  _DashedRRectPainter({
    required this.radius,
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().toList();

    for (final m in metrics) {
      double distance = 0;
      while (distance < m.length) {
        final next = (distance + dashWidth < m.length)
            ? distance + dashWidth
            : m.length;
        final seg = m.extractPath(distance, next);
        canvas.drawPath(seg, paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap;
  }
}
