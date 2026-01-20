import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/recipe.dart';
import 'loading_shimmer.dart';


class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isGrid;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.isGrid = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: isGrid ? _buildGridLayout(context) : _buildListLayout(context),
      ),
    );
  }

  Widget _buildGridLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Hero(
            tag: 'recipe_${recipe.id}',
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: recipe.thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const LoadingShimmer.rectangular(height: double.infinity),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (recipe.category != null)
                Text(
                  recipe.category!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListLayout(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Hero(
            tag: 'recipe_${recipe.id}',
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: recipe.thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const LoadingShimmer.rectangular(height: 120),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recipe.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                 if (recipe.category != null || recipe.area != null)
                Wrap(
                  spacing: 4,
                  children: [
                    if (recipe.category != null)
                      Chip(label: Text(recipe.category!, style: const TextStyle(fontSize: 10)), visualDensity: VisualDensity.compact,),
                    if (recipe.area != null)
                       Chip(label: Text(recipe.area!, style: const TextStyle(fontSize: 10)), visualDensity: VisualDensity.compact,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
