import 'package:flutter/material.dart';
import 'loading_shimmer.dart';

class RecipeListShimmer extends StatelessWidget {
  final bool isGrid;

  const RecipeListShimmer({super.key, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return isGrid ? _buildGrid() : _buildList();
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling while loading
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6, // Show 6 items for grid shimmer
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: LoadingShimmer.rectangular(height: double.infinity),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    LoadingShimmer.rectangular(height: 16, width: 100),
                    SizedBox(height: 8),
                    LoadingShimmer.rectangular(height: 12, width: 60),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // Show 6 items for list shimmer
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
                    child: LoadingShimmer.rectangular(height: 120),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        LoadingShimmer.rectangular(height: 16, width: 150),
                        SizedBox(height: 8),
                        LoadingShimmer.rectangular(height: 12, width: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
