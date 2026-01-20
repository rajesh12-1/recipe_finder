import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart' as di;
import 'core/theme/app_theme.dart';
import 'modules/recipe/presentation/pages/recipe_list_page.dart';
import 'modules/recipe/presentation/providers/recipe_list_provider.dart';
import 'modules/favorites/presentation/providers/favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeListProvider(
            searchRecipesUseCase: di.sl(),
            repository: di.sl(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(
            getFavoritesUseCase: di.sl(),
            toggleFavoriteUseCase: di.sl(),
            checkFavoriteStatusUseCase: di.sl(),
          ),
        ),
      ],

      child: MaterialApp(
        title: 'Recipe Finder',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const RecipeListPage(),
      ),
    );
  }
}
