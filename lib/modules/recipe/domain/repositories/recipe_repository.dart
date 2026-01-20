import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recipe.dart';
import '../entities/recipe_detail.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> searchRecipes(String query);
  Future<Either<Failure, List<Recipe>>> getRecipesByFilter({
    String? category,
    String? area,
    String? ingredient,
  });
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String id);
  Future<Either<Failure, List<Map<String, String>>>> getCategories();
  Future<Either<Failure, List<Map<String, String>>>> getAreas();
}
