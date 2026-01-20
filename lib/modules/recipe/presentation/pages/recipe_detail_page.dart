import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/di/service_locator.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart'; 
import '../providers/recipe_detail_provider.dart';

import '../widgets/loading_shimmer.dart';

class RecipeDetailPage extends StatelessWidget {
  final String recipeId;

  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeDetailProvider(getRecipeDetailUseCase: sl())..loadRecipeDetail(recipeId),
      child: RecipeDetailView(recipeId: recipeId),
    );
  }
}

class RecipeDetailView extends StatefulWidget {
  final String recipeId;
  const RecipeDetailView({super.key, required this.recipeId});

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  void _checkStatus() async {
    final status = await context.read<FavoritesProvider>().isFavorite(widget.recipeId);
    if (mounted) setState(() => isFavorite = status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RecipeDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          final recipe = provider.recipeDetail;
          if (recipe == null) return const SizedBox.shrink();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    recipe.name, 
                    style: const TextStyle(
                      color: Colors.white, 
                      shadows: [Shadow(color: Colors.black, blurRadius: 10)]
                    ),
                  ),
                  background: Hero(
                    tag: 'recipe_${recipe.id}',
                    child: CachedNetworkImage(
                      imageUrl: recipe.thumbnailUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const LoadingShimmer.rectangular(height: 300),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(label: Text(recipe.category), backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1)),
                            const SizedBox(width: 8),
                            Chip(label: Text(recipe.area), backgroundColor: Colors.blue.withOpacity(0.1)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        Text('Ingredients', style: Theme.of(context).textTheme.headlineSmall),
                        const Divider(),
                        ...List.generate(recipe.ingredients.length, (index) {
                          return ListTile(
                            dense: true,
                            leading: const Icon(Icons.circle, size: 8),
                            title: Text('${recipe.measures[index]} ${recipe.ingredients[index]}'),
                          );
                        }),
                        const SizedBox(height: 20),

                        Text('Instructions', style: Theme.of(context).textTheme.headlineSmall),
                        const Divider(),
                        Text(
                          recipe.instructions,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
                        ),
                        const SizedBox(height: 20),

                        if (recipe.youtubeUrl != null && recipe.youtubeUrl!.isNotEmpty) ...[
                           Text('Video Tutorial', style: Theme.of(context).textTheme.headlineSmall),
                           const SizedBox(height: 10),
                           _YoutubePlayerWidget(url: recipe.youtubeUrl!),
                           const SizedBox(height: 50),
                        ],
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isFavorite ? Colors.red : Theme.of(context).primaryColor,
        onPressed: () async {
           final detail = context.read<RecipeDetailProvider>().recipeDetail;
           if (detail != null) {
              await context.read<FavoritesProvider>().toggleFavorite(detail);
              _checkStatus();
           }
        },
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
      ),
    );
  }
}

class _YoutubePlayerWidget extends StatefulWidget {
  final String url;
  const _YoutubePlayerWidget({required this.url});

  @override
  State<_YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<_YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.url);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (YoutubePlayer.convertUrlToId(widget.url) == null) return const SizedBox.shrink();
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}
