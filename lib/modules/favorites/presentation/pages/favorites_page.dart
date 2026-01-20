import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../recipe/presentation/widgets/recipe_card.dart';
import '../../../recipe/domain/entities/recipe.dart';
import '../../../recipe/presentation/pages/recipe_detail_page.dart';
import '../providers/favorites_provider.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<FavoritesProvider>(context, listen: false).loadFavorites()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.favorites.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final fav = provider.favorites[index];
              final recipe = Recipe(
                id: fav.id,
                name: fav.name,
                thumbnailUrl: fav.thumbnailUrl,
                category: fav.category,
                area: fav.area,
              );

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RecipeCard(
                  recipe: recipe,
                  isGrid: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(recipeId: recipe.id),
                      ),
                    ).then((_) => provider.loadFavorites());
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
