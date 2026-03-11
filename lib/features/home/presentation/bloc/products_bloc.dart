import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../../domain/entities/product.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;

  ProductsBloc({required this.getProducts}) : super(const ProductsState()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateFilters>(_onUpdateFilters);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    
    final result = await getProducts();
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: ProductsStatus.failure,
        errorMessage: failure.message,
      )),
      (products) => emit(state.copyWith(
        status: ProductsStatus.success,
        products: products,
        filteredProducts: _applyFilters(products, state.filter),
      )),
    );
  }

  void _onUpdateFilters(UpdateFilters event, Emitter<ProductsState> emit) {
    final filtered = _applyFilters(state.products, event.filter);
    emit(state.copyWith(
      filter: event.filter,
      filteredProducts: filtered,
    ));
  }

  void _onSearchProducts(SearchProducts event, Emitter<ProductsState> emit) {
    final newFilter = state.filter.copyWith(searchQuery: event.query);
    final filtered = _applyFilters(state.products, newFilter);
    emit(state.copyWith(
      filter: newFilter,
      filteredProducts: filtered,
    ));
  }

  List<Product> _applyFilters(List<Product> products, dynamic filter) {
    List<Product> result = List.from(products);

    // Filter by Category
    if (filter.category != null && filter.category != 'All') {
      result = result.where((p) => p.category == filter.category).toList();
    }

    // Filter by Search Query
    if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
      result = result.where((p) => 
        p.name.toLowerCase().contains(filter.searchQuery!.toLowerCase()) ||
        p.category.toLowerCase().contains(filter.searchQuery!.toLowerCase())
      ).toList();
    }

    // Filter by Price Range
    if (filter.priceRange != null) {
      result = result.where((p) => 
        p.price >= filter.priceRange!.start && p.price <= filter.priceRange!.end
      ).toList();
    }

    // Sort
    if (filter.sortBy != null) {
      switch (filter.sortBy) {
        case 'Price: Low to High':
          result.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Price: High to Low':
          result.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'Newest':
          // Mocking newest by keeping original order or reversing
          break;
        case 'Popularity':
          result.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }
    }

    return result;
  }
}
