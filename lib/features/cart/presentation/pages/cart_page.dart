import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../checkout/presentation/pages/checkout_page.dart';
import '../../../home/presentation/pages/main_scaffold.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cart = state.cart;
            if (cart.items.isEmpty) {
              return _buildEmptyCart(context);
            }
            return Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    _buildAppBar(context),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 300.h),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final item = cart.items[index];
                            return _buildDismissibleCartItem(context, item, currencyFormatter);
                          },
                          childCount: cart.items.length,
                        ),
                      ),
                    ),
                  ],
                ),
                _buildCheckoutSection(context, cart, currencyFormatter),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120.h,
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        title: Text(
          l10n.myCart,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24.sp),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: IconButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              context.read<CartBloc>().add(ClearCart());
            },
            icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.error),
          ),
        ),
      ],
    );
  }

  Widget _buildDismissibleCartItem(BuildContext context, CartItem item, NumberFormat formatter) {
    return Dismissible(
      key: Key(item.product.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CartBloc>().add(RemoveFromCart(item.product.id));
        HapticFeedback.lightImpact();
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Icon(Icons.delete_outline, color: AppColors.error, size: 28.sp),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.surfaceLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            Hero(
              tag: 'cart_${item.product.id}',
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: DecorationImage(
                    image: NetworkImage(item.product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.product.getLocalizedName(context),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          context.read<CartBloc>().add(RemoveFromCart(item.product.id));
                        },
                        child: Icon(Icons.close, size: 18, color: AppColors.textTertiary.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  Text(
                    item.product.category,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatter.format(item.product.price),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildQuantityControl(context, item),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControl(BuildContext context, CartItem item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Row(
        children: [
          _qBtn(Icons.remove, () {
            if (item.quantity > 1) {
              HapticFeedback.lightImpact();
              context.read<CartBloc>().add(UpdateQuantity(item.product.id, item.quantity - 1));
            }
          }),
          Container(
            constraints: BoxConstraints(minWidth: 24.w),
            alignment: Alignment.center,
            child: Text(
              item.quantity.toString(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _qBtn(Icons.add, () {
            HapticFeedback.lightImpact();
            context.read<CartBloc>().add(UpdateQuantity(item.product.id, item.quantity + 1));
          }),
        ],
      ),
    );
  }

  Widget _qBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Icon(icon, size: 14, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, Cart cart, NumberFormat formatter) {
    final l10n = AppLocalizations.of(context)!;
    return Positioned(
      bottom: 100.h, // Space for bottom navigation bar
      left: 24.w,
      right: 24.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.9),
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSummaryRow(l10n.subtotal, formatter.format(cart.subtotal), false),
                SizedBox(height: 8.h),
                _buildSummaryRow(l10n.delivery, formatter.format(cart.deliveryFee), false),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Divider(color: Colors.white.withOpacity(0.05), height: 1),
                ),
                _buildSummaryRow(l10n.total, formatter.format(cart.total), true),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckoutPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.proceedToCheckout),
                      SizedBox(width: 12.w),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
              : TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
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

  Widget _buildEmptyCart(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(40.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(Icons.shopping_bag_outlined, size: 80.sp, color: AppColors.primary.withOpacity(0.5)),
          ),
          SizedBox(height: 32.h),
          Text(
            l10n.cartEmptyTitle,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.cartEmptySubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 48.h),
          SizedBox(
            width: 220.w,
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                MainScaffold.of(context)?.setSelectedIndex(1);
              },
              child: Text(l10n.startExploring),
            ),
          ),
        ],
      ),
    );
  }
}
