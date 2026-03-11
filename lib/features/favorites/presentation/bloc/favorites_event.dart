import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/product.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class ToggleFavorite extends FavoritesEvent {
  final Product product;

  const ToggleFavorite(this.product);

  @override
  List<Object?> get props => [product];
}

class ClearFavorites extends FavoritesEvent {}
