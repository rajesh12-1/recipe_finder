# Recipe Finder App

## 📖 Project Overview
Recipe Finder App is a comprehensive mobile application built with Flutter that allows users to discover, search, and manage recipes from various cuisines. The app provides a seamless user experience for finding cooking inspiration, viewing detailed ingredient lists and instructions, and saving favorite recipes for offline access. The application is designed to be intuitive, responsive, and visually appealing.

## ✨ Key Features

### For Users
*   **Smart Search**: Instantly find recipes by name using the powerful search functionality.
*   **Category Filtering**: Browse recipes by specific categories (e.g., Beef, Chicken, Vegetarian, Dessert) to find exactly what you're craving.
*   **Detailed Recipe View**: Access comprehensive details for every recipe, including:
    *   High-quality food imagery.
    *   Complete list of ingredients with precise measurements.
    *   Step-by-step cooking instructions.
    *   Integrated YouTube video tutorials for visual guidance.
*   **Favorites System**: Save your best-loved recipes to a "Favorites" list. These are stored locally on your device, allowing you to access them even without an internet connection.
*   **Responsive UI**: Enjoy a smooth, consistent experience with loading skeletons (shimmer effects) and adaptive layouts.

## 📸 Snapshots and Demo

### Screenshots
| | | |
|:---:|:---:|:---:|
| <img src="assets/snapshots and video of app/screenshot_1.jpg" width="200" /> | <img src="assets/snapshots and video of app/screenshot_2.jpg" width="200" /> | <img src="assets/snapshots and video of app/screenshot_3.jpg" width="200" /> |
| <img src="assets/snapshots and video of app/screenshot_4.jpg" width="200" /> | <img src="assets/snapshots and video of app/screenshot_5.jpg" width="200" /> | <img src="assets/snapshots and video of app/screenshot_6.jpg" width="200" /> |
| <img src="assets/snapshots and video of app/screenshot_7.jpg" width="200" /> | | |

### Demo Video
[Watch the App Demo](assets/snapshots%20and%20video%20of%20app/7.mp4)

## 🏗️ Technical Architecture

This project follows **Clean Architecture** principles to ensure scalability, maintainability, and testability. The codebase is strictly separated into three main layers:

1.  **Presentation Layer**: Handles the UI and State Management.
    *   **State Management**: Uses `Provider` for efficient state management and dependency injection.
    *   **Widgets**: built using standard Flutter widgets and custom components like `RecipeCard` and `LoadingShimmer`.
2.  **Domain Layer**: Contains the business logic and entities.
    *   Defines abstract `Repositories` and `UseCases` (e.g., `GetRecipeDetail`, `SearchRecipes`).
    *   Pure Dart code with no dependencies on external libraries or frameworks.
3.  **Data Layer**: Manages data retrieval and storage.
    *   **Remote Data**: Uses `Dio` for handling HTTP requests to the recipe API.
    *   **Local Data**: Uses `Hive` for fast, key-value storage to persist user favorites.
    *   **Models**: Data Transfer Objects (DTOs) that bridge the gap between API/Database and Domain Entities.

## 🛠️ Technology Stack

*   **Framework**: Flutter (Dart)
*   **Architecture**: Clean Architecture
*   **State Management**: Provider
*   **Networking**: Dio
*   **Local Storage**: Hive & Hive Flutter
*   **UI Libraries**:
    *   `shimmer`: For loading indicators.
    *   `cached_network_image`: For efficient image loading and caching.
    *   `youtube_player_flutter`: For embedding recipe videos.
    *   `google_fonts`: For custom typography.
*   **Dependency Injection**: GetIt

## 📂 Project Structure

The project is organized efficiently to support the Clean Architecture pattern:

```
lib/
├── core/                   # Core utilities shared across the app
│   ├── constants/          # App-wide constants (URLs, strings)
│   ├── di/                 # Dependency Injection setup (Service Locator)
│   ├── errors/             # Custom error handling and failures
│   └── network/            # API Clients and network connection utilities
├── modules/                # Feature-based modules
│   ├── favorites/          # Favorites feature
│   │   ├── data/           # Data layer for favorites (Hive implementations)
│   │   ├── domain/         # Domain layer for favorites
│   │   └── presentation/   # UI logic for favorites screen
│   └── recipe/             # Recipe discovery feature
│       ├── data/           # Data layer for recipes (API implementations)
│       ├── domain/         # Domain layer for recipes
│       └── presentation/   # UI logic for home and detail screens
└── main.dart               # Application entry point
```

## 🚀 Getting Started

To run this project locally, follow these steps:

1.  **Prerequisites**: Ensure you have Flutter SDK installed and set up.
2.  **Clone the Repository**:
    ```bash
    git clone https://github.com/your-username/recipe_finder_app.git
    cd recipe_finder_app
    ```
3.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the App**:
    ```bash
    flutter run
    ```

## 📄 License
This project is open-source and available for use under standard open-source licenses.
