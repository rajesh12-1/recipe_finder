import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_list_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_list_shimmer.dart';
import '../pages/recipe_detail_page.dart';  
import '../../../../modules/favorites/presentation/pages/favorites_page.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  final TextEditingController _searchController = TextEditingController();
  // Using a debouncer manually or just relying on submission for now as per simple requirement, 
  // but plan mentioned debounced. Let's do simple submission first or a simple timer.
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<RecipeListProvider>(context, listen: false).loadInitialData()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
        actions: [
          IconButton(
            icon: Consumer<RecipeListProvider>(
              builder: (_, provider, __) => Icon(
                provider.viewMode == ViewMode.grid 
                    ? Icons.list 
                    : Icons.grid_view
              ),
            ),
            onPressed: () {
              context.read<RecipeListProvider>().toggleViewMode();
            },
          ),
          IconButton(
             icon: const Icon(Icons.favorite),
             onPressed: () {
               // Navigation to Favorites
               // Since FavoritesPage was defined in a separate file, we need to import it or use named routes.
               // For simplicity, direct navigation:
               Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
             },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<RecipeListProvider>().searchRecipes(''); 
                  },
                ),
              ),
              onSubmitted: (value) {
                context.read<RecipeListProvider>().searchRecipes(value);
              },
            ),
          ),
          
          // Filters (Categories)
          // Filters (Categories)
          Consumer<RecipeListProvider>(
             builder: (context, provider, child) {
               if (provider.categories.isEmpty) return const SizedBox.shrink();
               
               // Create a list with 'All' at the start
               final categoriesToShow = [
                 {'strCategory': 'All'}, 
                 ...provider.categories
               ];

               return SizedBox(
                 height: 50,
                 child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                   itemCount: categoriesToShow.length,
                   itemBuilder: (context, index) {
                     final cat = categoriesToShow[index];
                     final categoryName = cat['strCategory']!;
                     final isSelected = provider.selectedCategory == categoryName;

                     return Padding(
                       padding: const EdgeInsets.only(right: 8),
                       child: FilterChip(
                         selected: isSelected,
                         showCheckmark: false,
                         label: Text(
                           categoryName,
                           style: TextStyle(
                             color: isSelected ? Colors.white : Colors.black87,
                             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                           ),
                         ),
                         selectedColor: Theme.of(context).primaryColor,
                         backgroundColor: Colors.grey[200],
                         onSelected: (_) {
                           context.read<RecipeListProvider>().filterRecipes(category: categoryName);
                         },
                       ),
                     );
                   },
                 ),
               );
             },
          ),
          const SizedBox(height: 10),

          // Recipe List
          Expanded(
            child: Consumer<RecipeListProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return RecipeListShimmer(isGrid: provider.viewMode == ViewMode.grid);
                }



                if (provider.errorMessage != null) {
                  return Center(child: Text(provider.errorMessage!));
                }

                if (provider.recipes.isEmpty) {
                  return const Center(child: Text('No recipes found. Try searching!'));
                }

                return provider.viewMode == ViewMode.grid
                    ? GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: provider.recipes.length,
                        itemBuilder: (context, index) {
                          return RecipeCard(
                            recipe: provider.recipes[index],
                            isGrid: true,
                            onTap: () => _navigateToDetail(context, provider.recipes[index].id),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: provider.recipes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: RecipeCard(
                              recipe: provider.recipes[index],
                              isGrid: false,
                              onTap: () => _navigateToDetail(context, provider.recipes[index].id),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String id) {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RecipeDetailPage(recipeId: id)),
    );
  }
}
