import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;
  final List<Product> filteredProducts;
  final ProductFilter filter;
  final String? errorMessage;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.filteredProducts = const [],
    this.filter = const ProductFilter(category: 'All', sortBy: 'Popularity'),
    this.errorMessage,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    List<Product>? filteredProducts,
    ProductFilter? filter,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      filter: filter ?? this.filter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, filteredProducts, filter, errorMessage];
}
