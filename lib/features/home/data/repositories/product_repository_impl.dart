import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      // Simulating network delay for realism
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(ProductModel.mockProducts);
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch products'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final products = ProductModel.mockProducts
          .where((p) => p.category == category)
          .toList();
      return Right(products);
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch category products'));
    }
  }
}
