import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recipe_detail.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeDetail {
  final RecipeRepository repository;

  GetRecipeDetail(this.repository);

  Future<Either<Failure, RecipeDetail>> call(String id) async {
    return await repository.getRecipeDetail(id);
  }
}
