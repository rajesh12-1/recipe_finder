import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../network/api_client.dart';

import '../../modules/recipe/data/datasources/recipe_remote_data_source.dart';
import '../../modules/recipe/data/repositories/recipe_repository_impl.dart';
import '../../modules/recipe/domain/repositories/recipe_repository.dart';
import '../../modules/recipe/domain/usecases/search_recipes.dart';
import '../../modules/recipe/domain/usecases/get_recipe_detail.dart';
import '../../modules/recipe/data/models/recipe_detail_model.dart'; // For Adapter
import '../../core/constants/app_constants.dart';

import '../../modules/favorites/data/datasources/favorites_local_data_source.dart';
import '../../modules/favorites/data/repositories/favorites_repository_impl.dart';
import '../../modules/favorites/domain/repositories/favorites_repository.dart';
import '../../modules/favorites/domain/usecases/get_favorites.dart';
import '../../modules/favorites/domain/usecases/toggle_favorite.dart';
import '../../modules/favorites/domain/usecases/check_favorite_status.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  await Hive.initFlutter();
  
  // Hive Adapters & Boxes
  Hive.registerAdapter(RecipeDetailModelAdapter());
  final favoritesBox = await Hive.openBox<RecipeDetailModel>(AppConstants.favoritesBox);

  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => ApiClient(dio: sl()));

  // Features - Recipe
  // Data Sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(remoteDataSource: sl()));

  // Use Cases
  sl.registerLazySingleton(() => SearchRecipes(sl()));
  sl.registerLazySingleton(() => GetRecipeDetail(sl()));

  // Features - Favorites
  // Data Sources
  sl.registerLazySingleton<FavoritesLocalDataSource>(
      () => FavoritesLocalDataSourceImpl(favoritesBox));

  // Repositories
  sl.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => CheckFavoriteStatus(sl()));
}


