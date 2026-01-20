import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../recipe/domain/entities/recipe_detail.dart';


abstract class FavoritesRepository {
  Future<Either<Failure, List<RecipeDetail>>> getFavorites();
  Future<Either<Failure, bool>> isFavorite(String id);
  Future<Either<Failure, void>> toggleFavorite(RecipeDetail recipe);
}
