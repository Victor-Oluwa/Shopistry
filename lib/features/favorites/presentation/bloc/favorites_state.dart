import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/product.dart';

abstract class FavoritesState extends Equatable {
  final List<Product> favorites;

  const FavoritesState({this.favorites = const []});

  @override
  List<Object?> get props => [favorites];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial() : super();
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(List<Product> favorites) : super(favorites: favorites);
}
