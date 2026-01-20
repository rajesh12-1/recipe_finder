import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../recipe/data/models/recipe_detail_model.dart';
import '../../../recipe/domain/entities/recipe_detail.dart';


abstract class FavoritesLocalDataSource {
  Future<List<RecipeDetailModel>> getFavorites();
  Future<void> addFavorite(RecipeDetailModel recipe);
  Future<void> removeFavorite(String id);
  Future<bool> isFavorite(String id);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<RecipeDetailModel> favoritesBox;

  FavoritesLocalDataSourceImpl(this.favoritesBox);

  @override
  Future<List<RecipeDetailModel>> getFavorites() async {
    try {
      return favoritesBox.values.toList();
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> addFavorite(RecipeDetailModel recipe) async {
    try {
      await favoritesBox.put(recipe.id, recipe);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<void> removeFavorite(String id) async {
    try {
      await favoritesBox.delete(id);
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<bool> isFavorite(String id) async {
    return favoritesBox.containsKey(id);
  }
}
