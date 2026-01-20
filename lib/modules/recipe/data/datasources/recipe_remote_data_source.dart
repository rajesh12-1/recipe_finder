import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../models/recipe_model.dart';
import '../models/recipe_detail_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> searchRecipes(String query);
  Future<List<RecipeModel>> getRecipesByFilter({String? category, String? area});
  Future<RecipeDetailModel> getRecipeDetail(String id);
  Future<List<Map<String, String>>> getCategories();
  Future<List<Map<String, String>>> getAreas();
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final ApiClient apiClient;

  RecipeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<RecipeModel>> searchRecipes(String query) async {
    try {
      final response = await apiClient.get(
        AppConstants.searchEndpoint,
        queryParameters: {'s': query},
      );
      
      if (response.data['meals'] == null) return [];
      
      return (response.data['meals'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'API Error');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<RecipeModel>> getRecipesByFilter({String? category, String? area}) async {
    try {
      final Map<String, dynamic> params = {};
      if (category != null) params['c'] = category;
      if (area != null) params['a'] = area;

      final response = await apiClient.get(
        AppConstants.filterEndpoint,
        queryParameters: params,
      );

      if (response.data['meals'] == null) return [];

      return (response.data['meals'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<RecipeDetailModel> getRecipeDetail(String id) async {
    try {
      final response = await apiClient.get(
        AppConstants.lookupEndpoint,
        queryParameters: {'i': id},
      );

      if (response.data['meals'] == null || (response.data['meals'] as List).isEmpty) {
         throw const ServerFailure('Recipe not found');
      }

      return RecipeDetailModel.fromJson(response.data['meals'][0]);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
  
  @override
  Future<List<Map<String, String>>> getCategories() async {
     try {
      final response = await apiClient.get(AppConstants.categoriesEndpoint);
      if (response.data['categories'] == null) return [];
      
      return (response.data['categories'] as List).map<Map<String, String>>((e) {
        return {
           'strCategory': e['strCategory'].toString(),
           'strCategoryThumb': e['strCategoryThumb'].toString()
        };
      }).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

   @override
  Future<List<Map<String, String>>> getAreas() async {
     try {
       // Areas endpoint is actually list.php?a=list
      final response = await apiClient.get(
          '/list.php',
          queryParameters: {'a': 'list'}
      );
      if (response.data['meals'] == null) return [];
      
      return (response.data['meals'] as List).map<Map<String, String>>((e) {
         return {'strArea': e['strArea'].toString()};
      }).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
