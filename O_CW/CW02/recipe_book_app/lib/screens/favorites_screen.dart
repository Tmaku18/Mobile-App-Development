import 'package:flutter/material.dart';

import '../data/recipes_data.dart';
import '../models/recipe.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Recipe> get _favorites =>
      sampleRecipes.where((r) => r.isFavorite).toList();

  @override
  Widget build(BuildContext context) {
    final favorites = _favorites;
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: favorites.isEmpty
          ? const Center(
              child: Text('No favourite recipes yet. Tap the heart on a recipe.'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final recipe = favorites[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(
                      recipe.imagePath,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                    title: Text(recipe.name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(recipe: recipe),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                );
              },
            ),
    );
  }
}
