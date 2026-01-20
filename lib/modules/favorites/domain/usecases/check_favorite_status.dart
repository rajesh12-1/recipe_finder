import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/favorites_repository.dart';

class CheckFavoriteStatus {
  final FavoritesRepository repository;

  CheckFavoriteStatus(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    return await repository.isFavorite(id);
  }
}
