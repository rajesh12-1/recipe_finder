import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../recipe/domain/entities/recipe_detail.dart';
import '../repositories/favorites_repository.dart';


class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<RecipeDetail>>> call() async {
    return await repository.getFavorites();
  }
}
