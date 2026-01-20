import 'package:flutter/material.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../../domain/usecases/search_recipes.dart';

enum ViewMode { grid, list }

class RecipeListProvider with ChangeNotifier {
  final SearchRecipes searchRecipesUseCase;
  final RecipeRepository repository; // Accessing repo for filters/categories directly for simplicity

  RecipeListProvider({
    required this.searchRecipesUseCase,
    required this.repository,
  });

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ViewMode _viewMode = ViewMode.grid;
  ViewMode get viewMode => _viewMode;

  List<Map<String, String>> _categories = [];
  List<Map<String, String>> get categories => _categories;
  
  List<Map<String, String>> _areas = [];
  List<Map<String, String>> get areas => _areas;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  String _currentQuery = 'Chicken'; // Default query

  void toggleViewMode() {
    _viewMode = _viewMode == ViewMode.grid ? ViewMode.list : ViewMode.grid;
    notifyListeners();
  }

  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    // Load categories for filter
    final catResult = await repository.getCategories();
    catResult.fold((l) => print('Error loading cats: ${l.message}'), (r) => _categories = r);
    
    // Load areas
    final areaResult = await repository.getAreas();
    areaResult.fold((l) => print('Error loading areas: ${l.message}'), (r) => _areas = r);

    // Initial random/default search
    searchRecipes(_currentQuery); 
  }

  Future<void> searchRecipes(String query) async {
    // If query is empty, use default, but allow empty to clear? 
    // Requirement says "initialy all filter is selected" and we show something.
    if (query.isNotEmpty) _currentQuery = query;
    
    _selectedCategory = 'All';
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await searchRecipesUseCase(_currentQuery);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _recipes = [];
      },
      (data) {
        _recipes = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> filterRecipes({required String category}) async {
    _selectedCategory = category;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (category == 'All') {
      // Revert to search results
      await searchRecipes(_currentQuery);
      return;
    }

    final result = await repository.getRecipesByFilter(category: category); // removed area support here for now to focus on category

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _recipes = [];
      },
      (data) {
        _recipes = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
