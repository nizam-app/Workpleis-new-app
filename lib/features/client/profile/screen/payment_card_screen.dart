import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'card_scan_screen.dart';

class PaymentCardScreen extends StatefulWidget {
  const PaymentCardScreen({super.key});

  static const String routeName = '/payment-card';

  @override
  State<PaymentCardScreen> createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String _selectedPaymentType = 'credit_card'; // 'credit_card' or 'apple_pay'

  @override
  void dispose() {
    _cardNumberController.dispose();
    _nameOnCardController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    // Handle continue logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment card added successfully'),
      ),
    );
    context.pop();
  }

  Future<void> _handleScanCard() async {
    final result = await context.push(CardScanScreen.routeName);
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _cardNumberController.text = result['cardNumber'] ?? '';
        _expiryDateController.text = result['expiryDate'] ?? '';
        _nameOnCardController.text = result['cardholderName'] ?? '';
      });
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
                        'Payment Card',
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
                    SizedBox(height: 32.h),

                    // Pay with Section
                    Text(
                      'Pay with',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Payment Method Buttons
                    Row(
                      children: [
                        // Credit Card Button (Selected)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPaymentType = 'credit_card';
                              });
                            },
                            child: Container(
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: AllColor.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _selectedPaymentType == 'credit_card'
                                      ? const Color(0xFF87B70F) // Lime green
                                      : AllColor.grey300,
                                  width: _selectedPaymentType == 'credit_card'
                                      ? 2
                                      : 1,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.credit_card,
                                  size: 24.sp,
                                  color: AllColor.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        // Apple Pay Button (Deselected)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPaymentType = 'apple_pay';
                              });
                            },
                            child: Container(
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: AllColor.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _selectedPaymentType == 'apple_pay'
                                      ? const Color(0xFF87B70F) // Lime green
                                      : AllColor.grey300,
                                  width: _selectedPaymentType == 'apple_pay'
                                      ? 2
                                      : 1,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Apple logo placeholder (using icon as placeholder)
                                    Icon(
                                      Icons.apple,
                                      size: 20.sp,
                                      color: AllColor.black,
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Pay',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AllColor.black,
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

                    SizedBox(height: 32.h),

                    // Your Card Details Section
                    Text(
                      'Your Card Details',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.black,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Scan your card field
                    Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8), // Light grey
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        readOnly: true,
                        onTap: _handleScanCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Scan your card',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AllColor.grey600,
                            fontFamily: 'sf_pro',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          suffixIcon: Icon(
                            Icons.camera_alt,
                            size: 24.sp,
                            color: AllColor.black,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Card number field
                    Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8), // Light grey
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Card number',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AllColor.grey600,
                            fontFamily: 'sf_pro',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          prefixIcon: Icon(
                            Icons.credit_card_outlined,
                            size: 24.sp,
                            color: AllColor.grey600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Name on card field
                    Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8), // Light grey
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        controller: _nameOnCardController,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.black,
                          fontFamily: 'sf_pro',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Name on card',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AllColor.grey600,
                            fontFamily: 'sf_pro',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Expiry date and CVV fields (side by side)
                    Row(
                      children: [
                        // Expiry date field
                        Expanded(
                          child: Container(
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8), // Light grey
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _expiryDateController,
                              readOnly: true,
                              onTap: () {
                                // Show date picker or dropdown
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Date picker (coming soon)'),
                                  ),
                                );
                              },
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AllColor.black,
                                fontFamily: 'sf_pro',
                              ),
                              decoration: InputDecoration(
                                hintText: 'Expiry date',
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AllColor.grey600,
                                  fontFamily: 'sf_pro',
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24.sp,
                                  color: AllColor.grey600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // CVV field
                        Expanded(
                          child: Container(
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8), // Light grey
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              maxLength: 3,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AllColor.black,
                                fontFamily: 'sf_pro',
                              ),
                              decoration: InputDecoration(
                                hintText: 'cvv',
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AllColor.grey600,
                                  fontFamily: 'sf_pro',
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                prefixIcon: Icon(
                                  Icons.credit_card_outlined,
                                  size: 24.sp,
                                  color: AllColor.grey600,
                                ),
                                counterText: '', // Hide character counter
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Continue Button
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.black,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
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
