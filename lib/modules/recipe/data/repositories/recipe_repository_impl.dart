import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_detail.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipes(String query) async {
    try {
      final result = await remoteDataSource.searchRecipes(query);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByFilter({
    String? category,
    String? area,
    String? ingredient,
  }) async {
    try {
      // API only supports one filter at a time for free tier
      final result = await remoteDataSource.getRecipesByFilter(
        category: category,
        area: area,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String id) async {
    try {
      final result = await remoteDataSource.getRecipeDetail(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Map<String, String>>>> getCategories() async {
     try {
      final result = await remoteDataSource.getCategories();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Map<String, String>>>> getAreas() async {
     try {
      final result = await remoteDataSource.getAreas();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
