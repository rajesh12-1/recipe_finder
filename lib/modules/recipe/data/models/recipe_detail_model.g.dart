// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeDetailModelAdapter extends TypeAdapter<RecipeDetailModel> {
  @override
  final int typeId = 0;

  @override
  RecipeDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeDetailModel(
      idMeal: fields[0] as String,
      strMeal: fields[1] as String,
      strCategory: fields[2] as String,
      strArea: fields[3] as String,
      strInstructions: fields[4] as String,
      strMealThumb: fields[5] as String,
      ingredients: (fields[8] as List).cast<String>(),
      measures: (fields[9] as List).cast<String>(),
      strYoutube: fields[6] as String?,
      strSource: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeDetailModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.idMeal)
      ..writeByte(1)
      ..write(obj.strMeal)
      ..writeByte(2)
      ..write(obj.strCategory)
      ..writeByte(3)
      ..write(obj.strArea)
      ..writeByte(4)
      ..write(obj.strInstructions)
      ..writeByte(5)
      ..write(obj.strMealThumb)
      ..writeByte(6)
      ..write(obj.strYoutube)
      ..writeByte(7)
      ..write(obj.strSource)
      ..writeByte(8)
      ..write(obj.ingredients)
      ..writeByte(9)
      ..write(obj.measures);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetailModel _$RecipeDetailModelFromJson(Map<String, dynamic> json) =>
    RecipeDetailModel(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strCategory: json['strCategory'] as String,
      strArea: json['strArea'] as String,
      strInstructions: json['strInstructions'] as String,
      strMealThumb: json['strMealThumb'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      measures:
          (json['measures'] as List<dynamic>).map((e) => e as String).toList(),
      strYoutube: json['strYoutube'] as String?,
      strSource: json['strSource'] as String?,
    );

Map<String, dynamic> _$RecipeDetailModelToJson(RecipeDetailModel instance) =>
    <String, dynamic>{
      'idMeal': instance.idMeal,
      'strMeal': instance.strMeal,
      'strCategory': instance.strCategory,
      'strArea': instance.strArea,
      'strInstructions': instance.strInstructions,
      'strMealThumb': instance.strMealThumb,
      'strYoutube': instance.strYoutube,
      'strSource': instance.strSource,
      'ingredients': instance.ingredients,
      'measures': instance.measures,
    };
