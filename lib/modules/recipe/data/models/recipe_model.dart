import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/recipe.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel extends Recipe {
  @JsonKey(name: 'idMeal')
  final String idMeal;
  
  @JsonKey(name: 'strMeal')
  final String strMeal;
  
  @JsonKey(name: 'strMealThumb')
  final String strMealThumb;

  const RecipeModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  }) : super(
          id: idMeal,
          name: strMeal,
          thumbnailUrl: strMealThumb,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}
