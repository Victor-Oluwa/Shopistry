import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductFilter extends Equatable {
  final String? category;
  final RangeValues? priceRange;
  final String? sortBy;
  final Color? color;
  final String? searchQuery;

  const ProductFilter({
    this.category,
    this.priceRange,
    this.sortBy,
    this.color,
    this.searchQuery,
  });

  ProductFilter copyWith({
    String? category,
    RangeValues? priceRange,
    String? sortBy,
    Color? color,
    String? searchQuery,
  }) {
    return ProductFilter(
      category: category ?? this.category,
      priceRange: priceRange ?? this.priceRange,
      sortBy: sortBy ?? this.sortBy,
      color: color ?? this.color,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [category, priceRange, sortBy, color, searchQuery];
}
