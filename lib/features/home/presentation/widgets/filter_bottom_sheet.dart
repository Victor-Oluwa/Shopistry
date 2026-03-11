import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/product_filter.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late ProductFilter _currentFilter;

  final List<String> _categories = ['All', 'Sofas', 'Chairs', 'Tables', 'Lamps', 'Decor'];
  final List<String> _sortOptions = ['Popularity', 'Newest', 'Price: Low to High', 'Price: High to Low'];

  final List<Color> _availableColors = [
    const Color(0xFF8D7B68), // Taupe
    const Color(0xFF242424), // Charcoal
    const Color(0xFFE0E0E0), // Grey
    const Color(0xFFD4AF37), // Gold/Mustard
    const Color(0xFF4A5D4E), // Sage
  ];

  static const double minPrice = 5000;
  static const double maxPrice = 2000000;

  @override
  void initState() {
    super.initState();
    _currentFilter = context.read<ProductsBloc>().state.filter;
    // Ensure default price range for Naira if null or invalid
    if (_currentFilter.priceRange == null || _currentFilter.priceRange!.start < minPrice || _currentFilter.priceRange!.end > maxPrice) {
      _currentFilter = _currentFilter.copyWith(priceRange: const RangeValues(minPrice, maxPrice));
    }
  }

  String _getCategoryDisplay(String category, AppLocalizations l10n) {
    switch (category) {
      case 'All': return l10n.categoryAll;
      case 'Sofas': return l10n.categorySofas;
      case 'Chairs': return l10n.categoryChairs;
      case 'Tables': return l10n.categoryTables;
      case 'Lamps': return l10n.categoryLamps;
      case 'Decor': return l10n.categoryDecor;
      default: return category;
    }
  }

  String _getSortOptionDisplay(String option, AppLocalizations l10n) {
    switch (option) {
      case 'Popularity': return l10n.popularity;
      case 'Newest': return l10n.newest;
      case 'Price: Low to High': return l10n.priceLowToHigh;
      case 'Price: High to Low': return l10n.priceHighToLow;
      default: return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Safety check for range slider values to prevent assertions
    final rangeValues = _currentFilter.priceRange ?? const RangeValues(minPrice, maxPrice);
    final safeRangeValues = RangeValues(
      rangeValues.start.clamp(minPrice, maxPrice),
      rangeValues.end.clamp(minPrice, maxPrice),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.filters,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24.sp),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentFilter = const ProductFilter(
                        category: 'All',
                        sortBy: 'Popularity',
                        priceRange: RangeValues(minPrice, maxPrice),
                      );
                    });
                  },
                  child: Text(
                    l10n.resetAll,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),

            _buildSectionTitle(l10n.sortBy),
            SizedBox(height: 16.h),
            _buildSortOptions(l10n),

            SizedBox(height: 32.h),
            _buildSectionTitle(l10n.category),
            SizedBox(height: 16.h),
            _buildCategoryGrid(l10n),

            SizedBox(height: 32.h),
            _buildSectionTitle(l10n.priceRange),
            SizedBox(height: 12.h),
            RangeSlider(
              values: safeRangeValues,
              min: minPrice,
              max: maxPrice,
              divisions: 100,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.surfaceLight,
              onChanged: (values) => setState(() => _currentFilter = _currentFilter.copyWith(priceRange: values)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₦${safeRangeValues.start.round()}', style: Theme.of(context).textTheme.titleSmall),
                  Text('₦${safeRangeValues.end.round()}', style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),

            SizedBox(height: 32.h),
            _buildSectionTitle(l10n.colors),
            SizedBox(height: 16.h),
            _buildColorSelector(),

            SizedBox(height: 48.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ProductsBloc>().add(UpdateFilters(_currentFilter));
                      Navigator.pop(context);
                    },
                    child: Text(l10n.applyFilters),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSortOptions(AppLocalizations l10n) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: _sortOptions.map((option) {
        final isSelected = _currentFilter.sortBy == option;
        return GestureDetector(
          onTap: () => setState(() => _currentFilter = _currentFilter.copyWith(sortBy: option)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                width: 1.5,
              ),
            ),
            child: Text(
              _getSortOptionDisplay(option, l10n),
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13.sp,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryGrid(AppLocalizations l10n) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 2.5,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        final isSelected = _currentFilter.category == category;
        return GestureDetector(
          onTap: () => setState(() => _currentFilter = _currentFilter.copyWith(category: category)),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Text(
              _getCategoryDisplay(category, l10n),
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13.sp,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorSelector() {
    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _availableColors.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final color = _availableColors[index];
          final isSelected = _currentFilter.color == color;
          return GestureDetector(
            onTap: () => setState(() => _currentFilter = _currentFilter.copyWith(color: color)),
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
