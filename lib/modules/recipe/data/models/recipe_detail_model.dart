import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/recipe_detail.dart';

part 'recipe_detail_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class RecipeDetailModel extends RecipeDetail {
  @HiveField(0)
  @JsonKey(name: 'idMeal')
  final String idMeal;

  @HiveField(1)
  @JsonKey(name: 'strMeal')
  final String strMeal;

  @HiveField(2)
  @JsonKey(name: 'strCategory')
  final String strCategory;

  @HiveField(3)
  @JsonKey(name: 'strArea')
  final String strArea;

  @HiveField(4)
  @JsonKey(name: 'strInstructions')
  final String strInstructions;

  @HiveField(5)
  @JsonKey(name: 'strMealThumb')
  final String strMealThumb;

  @HiveField(6)
  @JsonKey(name: 'strYoutube')
  final String? strYoutube;

  @HiveField(7)
  @JsonKey(name: 'strSource')
  final String? strSource;

  // Custom handling for ingredients/measures in factory
  @override
  @HiveField(8)
  final List<String> ingredients;
  
  @override
  @HiveField(9)
  final List<String> measures;


  const RecipeDetailModel({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.ingredients,
    required this.measures,
    this.strYoutube,
    this.strSource,
  }) : super(
          id: idMeal,
          name: strMeal,
          thumbnailUrl: strMealThumb,
          category: strCategory,
          area: strArea,
          instructions: strInstructions,
          ingredients: ingredients,
          measures: measures,
          youtubeUrl: strYoutube,
          sourceUrl: strSource,
        );


  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString().trim());
        if (measure != null && measure.toString().trim().isNotEmpty) {
          measures.add(measure.toString().trim());
        } else {
          measures.add(""); // Empty measure for the ingredient
        }
      }
    }

    return RecipeDetailModel(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'] ?? 'Unknown',
      strArea: json['strArea'] ?? 'Unknown',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strYoutube: json['strYoutube'],
      strSource: json['strSource'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}
