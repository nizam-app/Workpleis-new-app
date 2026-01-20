import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'payment_card_screen.dart';

class BillingPaymentScreen extends StatefulWidget {
  const BillingPaymentScreen({super.key});

  static const String routeName = '/billing-payment';

  @override
  State<BillingPaymentScreen> createState() => _BillingPaymentScreenState();
}

class _BillingPaymentScreenState extends State<BillingPaymentScreen> {
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    // Set default selected method if needed
    _selectedPaymentMethod = null; // No default selection
  }

  void _handlePayNow() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pay Now functionality (coming soon)')),
    );
  }

  void _handleAddBillingMethod() {
    context.push(PaymentCardScreen.routeName);
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
                        border: Border.all(color: AllColor.grey300, width: 1),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // Balance Section
                    Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF002807), // Dark green
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Container(
                      width: double.infinity,
                      // padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF87B70F), // Vibrant lime green
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Stack(
                        // clipBehavior: Clip.none,
                        children: [
                          // Decorative circular shape in top-right
                          Positioned(
                            top: -40.h,
                            right: -60.w,
                            child: Container(
                              width: 120.w,
                              height: 160.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B9600), // Lighter green
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
                                    color: AllColor.white.withOpacity(
                                      0.80,
                                    ), // Lighter green
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '500.00 SAR',
                                  style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AllColor.white, // Lighter green
                                    fontFamily: 'sf_pro',
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                // Pay Now Button
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: _handlePayNow,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AllColor.white,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Text(
                                        'Pay Now',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF87B70F),
                                          fontFamily: 'sf_pro',
                                        ),
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

                    SizedBox(height: 32.h),

                    // Billing Methods Section
                    Text(
                      'Billing Methods',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF002807), // Dark green
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Instructional Text
                    Text(
                      "You haven't set up any billing methods yet. Add a method so you can hire when you're ready",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.grey600,
                        fontFamily: 'sf_pro',
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Payment Method Cards
                    _PaymentMethodCard(
                      icon: _MastercardIcon(),
                      cardName: 'Master Card',
                      cardNumber: '**********987',
                      isSelected: _selectedPaymentMethod == 'mastercard',
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'mastercard';
                        });
                      },
                    ),
                    SizedBox(height: 16.h),
                    _PaymentMethodCard(
                      icon: _VisaIcon(),
                      cardName: 'Visa Card',
                      cardNumber: '**********098',
                      isSelected: _selectedPaymentMethod == 'visa',
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'visa';
                        });
                      },
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Add Billing Method Button
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleAddBillingMethod,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.black,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 20.sp, color: AllColor.white),
                        SizedBox(width: 8.w),
                        Text(
                          'Add a billing method',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AllColor.white,
                            fontFamily: 'sf_pro',
                          ),
                        ),
                      ],
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

class _PaymentMethodCard extends StatelessWidget {
  final Widget icon;
  final String cardName;
  final String cardNumber;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.icon,
    required this.cardName,
    required this.cardNumber,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8), // Light grey
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Card Icon
            SizedBox(width: 40.w, height: 40.w, child: icon),
            SizedBox(width: 16.w),
            // Card Info
            Expanded(
              child: Text(
                '$cardName $cardNumber',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  fontFamily: 'sf_pro',
                ),
              ),
            ),
            // Radio Button
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2D5016) // Dark green
                      : AllColor.grey300,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected
                    ? const Color(0xFF2D5016) // Dark green
                    : AllColor.white,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AllColor.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// Mastercard Icon - Two overlapping circles
class _MastercardIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Red-orange circle
        Positioned(
          left: 0,
          child: Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEB001B), // Red-orange
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Yellow-orange circle
        Positioned(
          right: 0,
          child: Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF79E1B), // Yellow-orange
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

// Visa Icon - Blue VISA logo
class _VisaIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 28.w,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F71), // Dark blue
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Center(
        child: Text(
          'VISA',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AllColor.white,
            fontFamily: 'sf_pro',
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
