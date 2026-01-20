import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../recipe/domain/entities/recipe_detail.dart';
import '../repositories/favorites_repository.dart';


class ToggleFavorite {
  final FavoritesRepository repository;

  ToggleFavorite(this.repository);

  Future<Either<Failure, void>> call(RecipeDetail recipe) async {
    return await repository.toggleFavorite(recipe);
  }
}
