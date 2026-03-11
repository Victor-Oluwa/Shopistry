import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/entities/product.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesInitial()) {
    on<ToggleFavorite>(_onToggleFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<FavoritesState> emit) {
    final currentFavorites = List<Product>.from(state.favorites);
    if (currentFavorites.any((p) => p.id == event.product.id)) {
      currentFavorites.removeWhere((p) => p.id == event.product.id);
    } else {
      currentFavorites.add(event.product);
    }
    emit(FavoritesLoaded(currentFavorites));
  }

  void _onClearFavorites(ClearFavorites event, Emitter<FavoritesState> emit) {
    emit(const FavoritesLoaded([]));
  }
}
