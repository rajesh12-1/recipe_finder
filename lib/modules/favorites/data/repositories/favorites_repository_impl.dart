import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../recipe/data/models/recipe_detail_model.dart';
import '../../../recipe/domain/entities/recipe_detail.dart';
import '../../domain/repositories/favorites_repository.dart';

import '../datasources/favorites_local_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<RecipeDetail>>> getFavorites() async {
    try {
      final result = await localDataSource.getFavorites();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final result = await localDataSource.isFavorite(id);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(RecipeDetail recipe) async {
    try {
      final isFav = await localDataSource.isFavorite(recipe.id);
      if (isFav) {
        await localDataSource.removeFavorite(recipe.id);
      } else {
        // Convert Entity to Model to save
        // We assume RecipeDetail passed in contains necessary info 
        // to reconstruct RecipeDetailModel OR we map it. 
        // Since we are reusing RecipeDetailModel as Entity implementation in some parts 
        // or just copying fields.
        final model = RecipeDetailModel(
          idMeal: recipe.id,
          strMeal: recipe.name,
          strCategory: recipe.category,
          strArea: recipe.area,
          strInstructions: recipe.instructions,
          strMealThumb: recipe.thumbnailUrl,
          strYoutube: recipe.youtubeUrl,
          strSource: recipe.sourceUrl,
          ingredients: recipe.ingredients,
          measures: recipe.measures,
        );
        await localDataSource.addFavorite(model);
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
