import 'package:equatable/equatable.dart';

class RecipeDetail extends Equatable {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients;
  final List<String> measures;
  final String? youtubeUrl;
  final String? sourceUrl;

  const RecipeDetail({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    required this.measures,
    this.youtubeUrl,
    this.sourceUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        thumbnailUrl,
        category,
        area,
        instructions,
        ingredients,
        measures,
        youtubeUrl,
        sourceUrl,
      ];
}
