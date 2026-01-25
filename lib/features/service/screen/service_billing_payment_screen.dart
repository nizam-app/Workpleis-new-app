import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ServiceBillingPaymentScreen extends StatefulWidget {
  const ServiceBillingPaymentScreen({super.key});

  static const String routeName = '/service-billing-payment';

  @override
  State<ServiceBillingPaymentScreen> createState() =>
      _ServiceBillingPaymentScreenState();
}

class _ServiceBillingPaymentScreenState
    extends State<ServiceBillingPaymentScreen> {
  final List<_EarningEntry> _earnings = [
    _EarningEntry(date: 'Jul 30, 2024', amount: '50 SAR'),
    _EarningEntry(date: 'Jul 10, 2024', amount: '100 SAR'),
    _EarningEntry(date: 'Jun 29, 2024', amount: '60 SAR'),
    _EarningEntry(date: 'Jun 20, 2024', amount: '40 SAR'),
    _EarningEntry(date: 'Jun 05, 2024', amount: '200 SAR'),
    _EarningEntry(date: 'Jun 01, 2024', amount: '50 SAR'),
  ];

  void _handlePayNow() {
    // Navigate to payment screen or show payment dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pay Now functionality (coming soon)')),
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
                        color: const Color(0xFFE0E0E0), // Light grey
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
                        'Billing & Payments',
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

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // Balance Section
                    Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Balance Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF76C11F), // Bright green
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Decorative darker green shape in top-right
                          Positioned(
                            top: -30.h,
                            right: -40.w,
                            child: Container(
                              width: 120.w,
                              height: 120.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFF5FA015), // Darker green
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          // Content
                          Padding(
                            padding: EdgeInsets.all(24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Balance available',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AllColor.white.withOpacity(0.9),
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '500.00 SAR',
                                  style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AllColor.white,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                // Pay Now Button
                                GestureDetector(
                                  onTap: _handlePayNow,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0F0F0), // Light grey/off-white
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      'Pay Now',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AllColor.black,
                                        fontFamily: 'sf_pro',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Summary Cards Row
                    Row(
                      children: [
                        // Payment Cleared Card
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0), // Light grey/off-white
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Cleared',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF888888), // Light grey text
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '\$200',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AllColor.black,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Active Orders Card
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0), // Light grey/off-white
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Active Orders',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF888888), // Light grey text
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '\$100',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AllColor.black,
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Earning History Section
                    Text(
                      'Earning History',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Earning List
                    ..._earnings.asMap().entries.map((entry) {
                      final index = entry.key;
                      final earning = entry.value;
                      return Column(
                        children: [
                          _EarningListItem(
                            date: earning.date,
                            amount: earning.amount,
                          ),
                          if (index < _earnings.length - 1)
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: const Color(0xFFE0E0E0), // Light grey divider
                            ),
                        ],
                      );
                    }),

                    SizedBox(height: 32.h),
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

class _EarningEntry {
  final String date;
  final String amount;

  _EarningEntry({
    required this.date,
    required this.amount,
  });
}

class _EarningListItem extends StatelessWidget {
  final String date;
  final String amount;

  const _EarningListItem({
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Earning',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF888888), // Light grey
                  fontFamily: 'sf_pro',
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF76C11F), // Bright green
              fontFamily: 'sf_pro',
            ),
          ),
        ],
      ),
    );
  }
}
