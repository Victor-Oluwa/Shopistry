import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../domain/entities/order.dart';
import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_event.dart';
import '../bloc/checkout_state.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currencyFormatter = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 0);

    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state.status == CheckoutStatus.success) {
          _showSuccessDialog(context);
        } else if (state.status == CheckoutStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? l10n.errorOccurred),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text(l10n.checkout),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (cartState is! CartLoaded) return const SizedBox.shrink();
              final cart = cartState.cart;

              return Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        _buildSectionHeader(l10n.deliveryAddress),
                        SizedBox(height: 16.h),
                        _buildAddressInput(context, state),
                        SizedBox(height: 32.h),
                        _buildSectionHeader(l10n.paymentMethod),
                        SizedBox(height: 16.h),
                        _buildPaymentMethods(context, state),
                        SizedBox(height: 32.h),
                        _buildSectionHeader(l10n.orderSummary),
                        SizedBox(height: 16.h),
                        _buildOrderSummary(cart, currencyFormatter),
                        SizedBox(height: 150.h),
                      ],
                    ),
                  ),
                  _buildBottomBar(context, cart, state, currencyFormatter),
                  if (state.status == CheckoutStatus.loading)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildAddressInput(BuildContext context, CheckoutState state) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: TextField(
        controller: _addressController,
        onChanged: (val) => context.read<CheckoutBloc>().add(UpdateAddress(val)),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: l10n.addressHint,
          prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.primary),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(20.w),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildPaymentMethods(BuildContext context, CheckoutState state) {
    final l10n = AppLocalizations.of(context)!;
    final methods = [
      {'name': l10n.creditCard, 'id': 'Credit Card', 'icon': Icons.credit_card},
      {'name': l10n.applePay, 'id': 'Apple Pay', 'icon': Icons.apple},
      {'name': l10n.payPal, 'id': 'PayPal', 'icon': Icons.account_balance_wallet_outlined},
    ];

    return Column(
      children: methods.map((method) {
        final isSelected = state.paymentMethod == method['id'];
        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            context.read<CheckoutBloc>().add(UpdatePaymentMethod(method['id'] as String));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  method['icon'] as IconData,
                  color: isSelected ? AppColors.primary : AppColors.textTertiary,
                ),
                SizedBox(width: 16.w),
                Text(
                  method['name'] as String,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.primary),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOrderSummary(dynamic cart, NumberFormat formatter) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        children: [
          _buildSummaryRow(l10n.subtotal, formatter.format(cart.subtotal), false),
          SizedBox(height: 12.h),
          _buildSummaryRow(l10n.deliveryFee, formatter.format(cart.deliveryFee), false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(color: AppColors.surfaceLight),
          ),
          _buildSummaryRow(l10n.total, formatter.format(cart.total), true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)
              : TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: isTotal
              ? TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.primary)
              : TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, dynamic cart, CheckoutState state, NumberFormat formatter) {
    final l10n = AppLocalizations.of(context)!;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 40.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: AppColors.surfaceLight)),
        ),
        child: ElevatedButton(
          onPressed: () {
            HapticFeedback.heavyImpact();
            final order = Order(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              items: List.from(cart.items),
              subtotal: cart.subtotal,
              deliveryFee: cart.deliveryFee,
              total: cart.total,
              address: state.address,
              paymentMethod: state.paymentMethod,
              createdAt: DateTime.now(),
            );
            context.read<CheckoutBloc>().add(PlaceOrder(order));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${l10n.confirmOrder} • ${formatter.format(cart.total)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(width: 12.w),
              const Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Order Success',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) {
        return const _SuccessPage();
      },
    );
  }
}

class _SuccessPage extends StatelessWidget {
  const _SuccessPage();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildSuccessIcon(),
              SizedBox(height: 48.h),
              Text(
                l10n.orderSuccessTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 28.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                l10n.orderSuccessSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(ClearCart());
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(l10n.backToHome),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 80.sp),
    );
  }
}
