import 'package:flutter/material.dart';
import '../../domain/entities/recipe_detail.dart';
import '../../domain/usecases/get_recipe_detail.dart';

class RecipeDetailProvider with ChangeNotifier {
  final GetRecipeDetail getRecipeDetailUseCase;

  RecipeDetailProvider({required this.getRecipeDetailUseCase});

  RecipeDetail? _recipeDetail;
  RecipeDetail? get recipeDetail => _recipeDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadRecipeDetail(String id) async {
    _isLoading = true;
    _errorMessage = null;
    _recipeDetail = null; // Reset previous detail
    notifyListeners();

    final result = await getRecipeDetailUseCase(id);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (data) {
        _recipeDetail = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
