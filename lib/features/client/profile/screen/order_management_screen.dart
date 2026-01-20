import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  static const String routeName = '/order-management';

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

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
                        'Order Management',
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

            // Tab Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  // Order History Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
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
                                  : AllColor.grey600,
                              fontFamily: 'sf_pro',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          if (_selectedTabIndex == 0)
                            Container(
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7A58E1), // Purple
                                borderRadius: BorderRadius.circular(1.5.r),
                              ),
                            )
                          else
                            SizedBox(height: 3.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  // Transaction Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
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
                                  : AllColor.grey600,
                              fontFamily: 'sf_pro',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          if (_selectedTabIndex == 1)
                            Container(
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF87B70F), // Lime green
                                borderRadius: BorderRadius.circular(1.5.r),
                              ),
                            )
                          else
                            SizedBox(height: 3.h),
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
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _OrderHistoryTab(),
                  _TransactionTab(),
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
  const _OrderHistoryTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        children: [
          // First Order Card (Expanded)
          _OrderCard(
            isExpanded: true,
            productImage: 'assets/images/Product_card.png',
            productTitle: 'I have two tickets for the Al-Nassr Paris match for sale design',
            productSubtitle: 'Banner Design',
            sellerName: 'Carlis pinho',
            timeAgo: '20 min ago',
            deliveryDate: 'July 30, 2024',
            statusButtons: [
              _StatusButton(
                label: 'Refund',
                backgroundColor: const Color(0xFFE0E0E0),
                textColor: const Color(0xFF444444),
              ),
              _StatusButton(
                label: 'Inprocess',
                backgroundColor: const Color(0xFFFFEDCC),
                textColor: const Color(0xFFFF9F00),
              ),
            ],
            ratings: [
              _RatingItem(label: 'Chat Communication', rating: 5.0),
              _RatingItem(label: 'Hard Work', rating: 5.0),
            ],
            review:
                'Wow, what a fantastic experience! Your assistance in grasping my vision and translating it accurately was invaluable. Thank you so much! I\'ll definitely be returning for more!',
          ),
          SizedBox(height: 16.h),
          // Second Order Card (Collapsed)
          _OrderCard(
            isExpanded: false,
            productImage: 'assets/images/Product_card.png',
            productTitle: 'I have two tickets for the Al-Nassr Paris match for sale design',
            productSubtitle: 'Banner Design',
            sellerName: 'Carlis pinho',
            timeAgo: '20 min ago',
            deliveryDate: 'July 30, 2024',
            statusButtons: [
              _StatusButton(
                label: 'Complete',
                backgroundColor: const Color(0xFFE0EFFF),
                textColor: const Color(0xFF3B82F6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Order Card Widget
class _OrderCard extends StatelessWidget {
  final bool isExpanded;
  final String productImage;
  final String productTitle;
  final String productSubtitle;
  final String sellerName;
  final String timeAgo;
  final String deliveryDate;
  final List<_StatusButton> statusButtons;
  final List<_RatingItem>? ratings;
  final String? review;

  const _OrderCard({
    required this.isExpanded,
    required this.productImage,
    required this.productTitle,
    required this.productSubtitle,
    required this.sellerName,
    required this.timeAgo,
    required this.deliveryDate,
    required this.statusButtons,
    this.ratings,
    this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(20.r),
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
          // Product Information
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  productImage,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60.w,
                      height: 60.w,
                      color: AllColor.grey100,
                      child: Icon(Icons.image, size: 24.sp),
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productTitle,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      productSubtitle,
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
            ],
          ),
          SizedBox(height: 16.h),

          // Seller Information & Action Buttons
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/carlis.png',
                  width: 32.w,
                  height: 32.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 32.w,
                      height: 32.w,
                      color: AllColor.grey100,
                      child: Icon(Icons.person, size: 16.sp),
                    );
                  },
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sellerName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      timeAgo,
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: statusButtons
                    .map((button) => Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: _StatusButtonWidget(button: button),
                        ))
                    .toList(),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Delivery Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    size: 16.sp,
                    color: AllColor.grey600,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Delivery Date',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.grey600,
                      fontFamily: 'sf_pro',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Text(
                  deliveryDate,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
            ],
          ),

          // Expanded Content (Ratings & Review)
          if (isExpanded && ratings != null) ...[
            SizedBox(height: 20.h),
            // Overall Rating Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Overall rating',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16.sp,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '5.0',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ...ratings!.map((rating) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _RatingItemWidget(rating: rating),
                )),
            if (review != null) ...[
              SizedBox(height: 12.h),
              Text(
                review!,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                  height: 1.5,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

// Status Button Widget
class _StatusButton {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  _StatusButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
}

class _StatusButtonWidget extends StatelessWidget {
  final _StatusButton button;

  const _StatusButtonWidget({required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: button.backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        button.label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: button.textColor,
          fontFamily: 'sf_pro',
        ),
      ),
    );
  }
}

// Rating Item Widget
class _RatingItem {
  final String label;
  final double rating;

  _RatingItem({required this.label, required this.rating});
}

class _RatingItemWidget extends StatelessWidget {
  final _RatingItem rating;

  const _RatingItemWidget({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            rating.label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.grey600,
              fontFamily: 'sf_pro',
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 16.sp,
              color: Colors.amber,
            ),
            SizedBox(width: 4.w),
            Text(
              rating.rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AllColor.grey600,
                fontFamily: 'sf_pro',
              ),
            ),
          ],
        ),
      ],
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
                  color: const Color(0xFF87B70F), // Lime green
                  fontFamily: 'sf_pro',
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Statement Date Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statement Date',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.grey600,
                  fontFamily: 'sf_pro',
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  // Handle date selection
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jun 30,2024 - Aug 1,2024',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        size: 18.sp,
                        color: AllColor.grey600,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Transaction List Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.grey600,
                  fontFamily: 'sf_pro',
                ),
              ),
              Text(
                'Amount',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.grey600,
                  fontFamily: 'sf_pro',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Transaction List Items
          ...List.generate(4, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jun 30, 2024',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    Text(
                      '300 SAR',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
