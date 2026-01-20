import 'package:flutter/material.dart';
import '../../../recipe/domain/entities/recipe_detail.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/toggle_favorite.dart';
import '../../domain/usecases/check_favorite_status.dart';


class FavoritesProvider with ChangeNotifier {
  final GetFavorites getFavoritesUseCase;
  final ToggleFavorite toggleFavoriteUseCase;
  final CheckFavoriteStatus checkFavoriteStatusUseCase;

  FavoritesProvider({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
    required this.checkFavoriteStatusUseCase,
  });

  List<RecipeDetail> _favorites = [];
  List<RecipeDetail> get favorites => _favorites;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    final result = await getFavoritesUseCase();
    result.fold(
      (l) => print('Error loading favorites: ${l.message}'), // Ideally handle error state
      (r) => _favorites = r,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(RecipeDetail recipe) async {
    final result = await toggleFavoriteUseCase(recipe);
    result.fold(
      (l) => print('Error toggling favorite: ${l.message}'),
      (r) {
        loadFavorites(); // Refresh list if we are on favorites page
        notifyListeners();
      },
    );
  }

  Future<bool> isFavorite(String id) async {
    final result = await checkFavoriteStatusUseCase(id);
    return result.getOrElse(() => false);
  }
}
