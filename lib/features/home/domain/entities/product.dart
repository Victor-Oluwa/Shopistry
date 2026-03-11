import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final double rating;
  final String description;
  final String dimensions;
  final String material;
  final String weight;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.dimensions,
    required this.material,
    required this.weight,
  });

  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (id) {
      case '1': return l10n.product_1_name;
      case '2': return l10n.product_2_name;
      case '3': return l10n.product_3_name;
      case '4': return l10n.product_4_name;
      case '5': return l10n.product_5_name;
      case '6': return l10n.product_6_name;
      case '7': return l10n.product_7_name;
      case '8': return l10n.product_8_name;
      case '9': return l10n.product_9_name;
      case '10': return l10n.product_10_name;
      case '11': return l10n.product_11_name;
      case '12': return l10n.product_12_name;
      default: return name;
    }
  }

  String getLocalizedDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (id) {
      case '1': return l10n.product_1_description;
      case '2': return l10n.product_2_description;
      case '3': return l10n.product_3_description;
      case '4': return l10n.product_4_description;
      case '5': return l10n.product_5_description;
      case '6': return l10n.product_6_description;
      case '7': return l10n.product_7_description;
      case '8': return l10n.product_8_description;
      case '9': return l10n.product_9_description;
      case '10': return l10n.product_10_description;
      case '11': return l10n.product_11_description;
      case '12': return l10n.product_12_description;
      default: return description;
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        price,
        imageUrl,
        rating,
        description,
        dimensions,
        material,
        weight,
      ];
}
