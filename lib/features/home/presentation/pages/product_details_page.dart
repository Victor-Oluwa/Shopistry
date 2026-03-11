import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites_event.dart';
import '../../../favorites/presentation/bloc/favorites_state.dart';
import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_state.dart';
import '../widgets/product_card.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final String? heroTag;

  const ProductDetailsPage({
    super.key, 
    required this.product,
    this.heroTag,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with SingleTickerProviderStateMixin {
  int _quantity = 1;
  int _selectedColorIndex = 0;
  bool _isDescriptionExpanded = false;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Color> _availableColors = [
    AppColors.primary,
    const Color(0xFF4A4A4A),
    const Color(0xFFC8B6A6),
    const Color(0xFF8E8E8E),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );
    _animationController.forward();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currencyFormatter = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 0);
    final double appBarOpacity = (_scrollOffset / 300).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverHeader(),
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 160.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitleSection(),
                          SizedBox(height: 32.h),
                          _buildFeatureGrid(),
                          SizedBox(height: 32.h),
                          _buildDescriptionSection(),
                          SizedBox(height: 32.h),
                          _buildSelectionSection(),
                          SizedBox(height: 48.h),
                          _buildRelatedProducts(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Top Navigation Bar
          _buildTopNavigationBar(appBarOpacity),

          // Bottom Action Bar
          _buildBottomActionBar(currencyFormatter),
        ],
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      expandedHeight: 500.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: widget.heroTag ?? 'product_${widget.product.id}',
              child: CustomNetworkImage(
                imageUrl: widget.product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Artistic Overlay Gradients
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.background.withOpacity(0.8),
                    AppColors.background,
                  ],
                  stops: const [0.0, 0.2, 0.6, 0.9, 1.0],
                ),
              ),
            ),
            // Image Indicators Placeholder
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) => Container(
                  width: index == 0 ? 24.w : 6.w,
                  height: 6.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: index == 0 ? AppColors.primary : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigationBar(double opacity) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10 * opacity, sigmaY: 10 * opacity),
          child: Container(
            height: 100.h,
            padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
            color: AppColors.background.withOpacity(opacity * 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                  opaque: opacity < 0.2,
                ),
                if (opacity > 0.7)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        widget.product.getLocalizedName(context),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                Row(
                  children: [
                    _buildNavButton(
                      icon: Icons.share_outlined,
                      onTap: () {},
                      opaque: opacity < 0.2,
                    ),
                    SizedBox(width: 12.w),
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        final isFavorite = state.favorites.any((p) => p.id == widget.product.id);
                        return _buildNavButton(
                          icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? AppColors.error : Colors.white,
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            context.read<FavoritesBloc>().add(ToggleFavorite(widget.product));
                          },
                          opaque: opacity < 0.2,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.white,
    bool opaque = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: opaque ? Colors.black.withOpacity(0.4) : Colors.transparent,
          shape: BoxShape.circle,
          border: opaque ? Border.all(color: Colors.white.withOpacity(0.15)) : null,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Text(
                widget.product.category.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                SizedBox(width: 4.w),
                Text(
                  widget.product.rating.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' (120+)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          widget.product.getLocalizedName(context),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildFeatureCard(Icons.straighten_rounded, l10n.dimensions, widget.product.dimensions),
          SizedBox(width: 16.w),
          _buildFeatureCard(Icons.category_outlined, l10n.material, widget.product.material),
          SizedBox(width: 16.w),
          _buildFeatureCard(Icons.monitor_weight_outlined, l10n.weight, widget.product.weight),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String label, String value) {
    return Container(
      width: 130.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 24.sp),
          SizedBox(height: 16.h),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textTertiary),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.description,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.getLocalizedDescription(context),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                maxLines: _isDescriptionExpanded ? null : 3,
                overflow: _isDescriptionExpanded ? null : TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              Text(
                _isDescriptionExpanded ? l10n.readLess : l10n.readMore,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionSection() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.selectColor,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              Row(
                children: List.generate(_availableColors.length, (index) => _buildColorDot(index)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.quantity,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              _buildQuantitySelector(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorDot(int index) {
    final isSelected = _selectedColorIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedColorIndex = index),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: _availableColors[index],
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQtyBtn(Icons.remove, () {
            if (_quantity > 1) setState(() => _quantity--);
          }),
          SizedBox(
            width: 32.w,
            child: Text(
              _quantity.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildQtyBtn(Icons.add, () => setState(() => _quantity++)),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildRelatedProducts() {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        final similarProducts = state.products
            .where((p) => p.category == widget.product.category && p.id != widget.product.id)
            .take(4)
            .toList();

        if (similarProducts.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.similarProducts,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 300.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: similarProducts.length,
                separatorBuilder: (context, index) => SizedBox(width: 20.w),
                itemBuilder: (context, index) {
                  final similarProduct = similarProducts[index];
                  return SizedBox(
                    width: 170.w,
                    child: ProductCard(
                      key: ValueKey('similar_product_${similarProduct.id}'),
                      product: similarProduct,
                      heroTag: 'similar_product_${similarProduct.id}',
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomActionBar(NumberFormat formatter) {
    final l10n = AppLocalizations.of(context)!;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 40.h),
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(0.8),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.total,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textTertiary),
                    ),
                    Text(
                      formatter.format(widget.product.price * _quantity),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      context.read<CartBloc>().add(AddToCart(quantity: _quantity, product: widget.product,));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.addedToCart(widget.product.getLocalizedName(context))),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    ),
                    child: Text(
                      l10n.addToCart,
                      style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
