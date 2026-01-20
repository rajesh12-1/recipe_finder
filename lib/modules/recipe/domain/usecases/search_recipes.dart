import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class SearchRecipes {
  final RecipeRepository repository;

  SearchRecipes(this.repository);

  Future<Either<Failure, List<Recipe>>> call(String query) async {
    return await repository.searchRecipes(query);
  }
}
