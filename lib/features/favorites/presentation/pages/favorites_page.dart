import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/widgets/product_card.dart';
import '../../../home/presentation/pages/main_scaffold.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(context, state.favorites.length),
              if (state.favorites.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(context),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 120.h),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.54,
                      mainAxisSpacing: 24.h,
                      crossAxisSpacing: 20.w,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final product = state.favorites[index];
                        return ProductCard(product: product);
                      },
                      childCount: state.favorites.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, int count) {
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
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.wishlist,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 24.sp,
                height: 1.2,
              ),
            ),
            if (count > 0)
              Text(
                l10n.itemsYouLove(count),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
      actions: [
        if (count > 0)
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              onPressed: () {
                _showClearConfirmation(context);
              },
              icon: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.delete_outline, color: AppColors.error, size: 20.sp),
              ),
            ),
          ),
      ],
    );
  }

  void _showClearConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
          title: Text(l10n.clearWishlistTitle, style: Theme.of(context).textTheme.headlineSmall),
          content: Text(l10n.clearWishlistContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel, style: const TextStyle(color: AppColors.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                context.read<FavoritesBloc>().add(ClearFavorites());
                Navigator.pop(dialogContext);
                HapticFeedback.mediumImpact();
              },
              child: Text(l10n.clearAll, style: const TextStyle(color: AppColors.error)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
                  color: AppColors.primary.withOpacity(0.05),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 80.sp,
                  color: AppColors.primary.withOpacity(0.2),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Icon(
                    Icons.add_circle,
                    size: 24.sp,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            l10n.wishlistEmptyTitle,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 22.sp),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              l10n.wishlistEmptySubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 48.h),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              MainScaffold.of(context)?.setSelectedIndex(1);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              minimumSize: Size(0, 54.h),
            ),
            child: Text(l10n.discoverProducts),
          ),
        ],
      ),
    );
  }
}
