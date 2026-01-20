import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String? category;
  final String? area;

  const Recipe({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    this.category,
    this.area,
  });

  @override
  List<Object?> get props => [id, name, thumbnailUrl, category, area];
}
