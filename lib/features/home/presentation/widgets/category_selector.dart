import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  final List<String> _categories = const ['All', 'Sofas', 'Chairs', 'Tables', 'Lamps', 'Decor'];

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return SizedBox(
          height: 54.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = state.filter.category == category;

              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<ProductsBloc>().add(UpdateFilters(
                    state.filter.copyWith(category: category),
                  ));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surface.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected 
                          ? AppColors.primary 
                          : AppColors.surfaceLight.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ] : [],
                  ),
                  child: Center(
                    child: Text(
                      _getCategoryDisplay(category, l10n),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
