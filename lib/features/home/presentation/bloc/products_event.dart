import 'package:equatable/equatable.dart';
import '../../domain/entities/product_filter.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {}

class UpdateFilters extends ProductsEvent {
  final ProductFilter filter;
  const UpdateFilters(this.filter);

  @override
  List<Object?> get props => [filter];
}

class SearchProducts extends ProductsEvent {
  final String query;
  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}
