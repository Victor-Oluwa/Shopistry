import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/product_card.dart';
import '../../domain/entities/product_filter.dart';

class ProductsPage extends StatefulWidget {
  final String? initialCategory;
  const ProductsPage({super.key, this.initialCategory});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentFilter = context.read<ProductsBloc>().state.filter;
        context.read<ProductsBloc>().add(UpdateFilters(
          currentFilter.copyWith(category: widget.initialCategory),
        ));
      });
    }
  }

  void _showFilter() {
    final productsBloc = context.read<ProductsBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: productsBloc,
        child: const FilterBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: ProductsBackgroundPainter(),
                ),
              ),
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 120.h,
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: AppColors.background.withOpacity(0.8),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      centerTitle: false,
                      title: Text(
                        state.filter.category == 'All' ? l10n.allProducts : state.filter.category!,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                    actions: [
                      IconButton(
                        onPressed: _showFilter,
                        icon: const Icon(Icons.tune),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSearchBar(context),
                          if (state.filter != const ProductFilter(category: 'All', sortBy: 'Popularity'))
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: _buildActiveFilters(state),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (state.status == ProductsStatus.loading)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.filteredProducts.isEmpty)
                    SliverFillRemaining(
                      child: _buildEmptyState(),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 24.h,
                          crossAxisSpacing: 20.w,
                          childAspectRatio: 0.62,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductCard(product: state.filteredProducts[index]);
                          },
                          childCount: state.filteredProducts.length,
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20, color: AppColors.textTertiary),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ProductsBloc>().add(const SearchProducts(''));
                    setState(() {});
                  },
                )
              : null,
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
        onChanged: (val) {
          context.read<ProductsBloc>().add(SearchProducts(val));
          setState(() {});
        },
      ),
    );
  }

  Widget _buildActiveFilters(ProductsState state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (state.filter.category != 'All')
            _buildFilterChip(state.filter.category!, () {
              context.read<ProductsBloc>().add(UpdateFilters(state.filter.copyWith(category: 'All')));
            }),
          if (state.filter.priceRange != null && state.filter.priceRange != const RangeValues(5000, 2000000))
            _buildFilterChip('₦${state.filter.priceRange!.start.round()} - ₦${state.filter.priceRange!.end.round()}', () {
              context.read<ProductsBloc>().add(UpdateFilters(state.filter.copyWith(priceRange: const RangeValues(5000, 2000000))));
            }),
          if (state.filter.sortBy != 'Popularity')
            _buildFilterChip(state.filter.sortBy!, () {
              context.read<ProductsBloc>().add(UpdateFilters(state.filter.copyWith(sortBy: 'Popularity')));
            }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onClear) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surface, AppColors.surfaceLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onClear,
            child: Icon(Icons.close, size: 14.sp, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search_off_rounded, size: 48.sp, color: AppColors.primary.withOpacity(0.5)),
          ),
          SizedBox(height: 24.h),
          Text(
            l10n.noProductsFound,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.tryAdjustingFilters,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class ProductsBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.2,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.3,
      size.width,
      size.height * 0.25,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = AppColors.accent.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.05),
      size.width * 0.4,
      paint2,
    );
    
    // Bottom accent
    final paint3 = Paint()
      ..color = AppColors.primary.withOpacity(0.04)
      ..style = PaintingStyle.fill;
      
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.9),
      size.width * 0.3,
      paint3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
