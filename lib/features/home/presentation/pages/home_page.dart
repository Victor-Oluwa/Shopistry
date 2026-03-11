import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../widgets/category_selector.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/product_card.dart';
import '../widgets/home_background_painter.dart';
import 'products_page.dart';
import '../../domain/entities/product_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  void _showFilter(BuildContext context) {
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
          body: Stack(
            children: [
              // Custom Background Paint
              Positioned.fill(
                child: CustomPaint(
                  painter: ModernBackgroundPainter(),
                ),
              ),
              SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Custom App Bar
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 12.w,
                                        height: 2.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(1.r),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        l10n.welcomeBack.toUpperCase(),
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    l10n.discoverStyle,
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                      height: 1.1,
                                      letterSpacing: -1.0,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 32.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.w),
                            _buildIconButton(Icons.notifications_none_rounded),
                          ],
                        ),
                      ),
                    ),

                    // Search Bar
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 30,
                                      offset: const Offset(0, 15),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  onSubmitted: (query) {
                                    if (query.isNotEmpty) {
                                      context.read<ProductsBloc>().add(SearchProducts(query));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ProductsPage(),
                                        ),
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: l10n.searchHint,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: const Icon(Icons.search_rounded, color: AppColors.textTertiary),
                                    ),
                                    prefixIconConstraints: BoxConstraints(minWidth: 40.w),
                                    fillColor: AppColors.surface.withOpacity(0.9),
                                    contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                                    suffixIcon: _searchController.text.isNotEmpty
                                        ? IconButton(
                                      icon: const Icon(Icons.clear_rounded, size: 20),
                                      onPressed: () {
                                        _searchController.clear();
                                        context.read<ProductsBloc>().add(const SearchProducts(''));
                                        setState(() {});
                                      },
                                    )
                                        : null,
                                  ),
                                  onChanged: (val) => setState(() {}),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            GestureDetector(
                              onTap: () => _showFilter(context),
                              child: Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [AppColors.primary, AppColors.primaryDark],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(18.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.4),
                                      blurRadius: 15,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.tune_rounded, color: Colors.white, size: 24),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Promo Banner
                    SliverPadding(
                      padding: EdgeInsets.all(24.w),
                      sliver: SliverToBoxAdapter(
                        child: Hero(
                          tag: 'promo_banner',
                          child: Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 25,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                              image: const DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=2070&auto=format&fit=crop'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(28.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.r),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  stops: const [0.2, 0.8],
                                  colors: [
                                    Colors.black.withOpacity(0.85),
                                    Colors.black.withOpacity(0.1),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(30.r),
                                      border: Border.all(color: AppColors.accent.withOpacity(0.3), width: 1),
                                    ),
                                    child: Text(
                                      l10n.newSeason.toUpperCase(),
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppColors.accent,
                                        letterSpacing: 2.5,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    l10n.modernLuxuryCollection,
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                      color: Colors.white,
                                      fontSize: 26.sp,
                                      height: 1.1,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Categories Header
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      sliver: SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Row(
                            children: [
                              Text(
                                l10n.categories,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 40.w,
                                height: 1.h,
                                color: AppColors.surfaceLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Categories
                    const SliverToBoxAdapter(
                      child: CategorySelector(),
                    ),

                    // Section Header
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 20.h),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                l10n.popularProducts,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            TextButton(
                              onPressed: () {
                                context.read<ProductsBloc>().add(const UpdateFilters(
                                    ProductFilter(category: 'All', sortBy: 'Popularity')
                                ));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProductsPage()),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                backgroundColor: AppColors.primary.withOpacity(0.08),
                              ),
                              child: Text(
                                l10n.viewAll,
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Product Grid
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 28.h,
                          crossAxisSpacing: 20.w,
                          childAspectRatio: 0.45, // Set to 0.45 to ensure enough height for all content
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            if (index >= state.filteredProducts.length) return null;
                            final product = state.filteredProducts[index];
                            return ProductCard(
                              key: ValueKey('home_product_${product.id}'),
                              product: product,
                              heroTag: 'home_product_${product.id}', // Pass unique tag prefix
                            );
                          },
                          childCount: state.filteredProducts.length > 4 ? 4 : state.filteredProducts.length,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(child: SizedBox(height: 120.h)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, size: 24, color: AppColors.textPrimary),
    );
  }
}
