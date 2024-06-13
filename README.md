# Recipe App

Welcome to the Recipe App! This Flutter application provides a beautiful and user-friendly interface for discovering and exploring recipes from around the world. It leverages the free API from [TheMealDB.com](https://www.themealdb.com) to fetch a vast collection of recipes and displays them with stunning animations.

## User interface
![alt text](./images/img1.png)

## Features

- **Beautiful UI**: Enjoy a clean, modern, and intuitive user interface that makes browsing and searching for recipes a delightful experience.
- **Stunning Animations**: Experience smooth and captivating animations that enhance the visual appeal and user experience of the app.
- **Extensive Recipe Database**: Access a wide variety of recipes from different cuisines, all sourced from TheMealDB.com.
- **Detailed Recipe Information**: Get comprehensive details about each recipe, including ingredients, instructions, and images.
- **Search Functionality**: Easily search for recipes by name or ingredients to find exactly what you're looking for.

## Getting Started

Follow these instructions to set up and run the Recipe App on your local machine.

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 2.0 or higher)

### Installation

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/yagnesh0312/recipe_app.git
    cd recipe-app
    ```

2. **Get Dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the App**:
    ```sh
    flutter run
    ```

The app should now be running on your connected device or emulator.

## Usage

- **Browse Recipes**: Navigate through the app to explore a wide range of recipes. Tap on any recipe to view its details.
- **Search Recipes**: Use the search bar to find recipes by name or ingredients.
- **Recipe Details**: Tap on a recipe to view its detailed information, including ingredients, preparation instructions, and an image of the finished dish.

## API Reference

The app uses the [TheMealDB API](https://www.themealdb.com/api.php) to fetch recipe data. Here are some key endpoints used in the app:

- **Search by Name**:
    ```sh
    GET https://www.themealdb.com/api/json/v1/1/search.php?s={name}
    ```
- **Lookup by ID**:
    ```sh
    GET https://www.themealdb.com/api/json/v1/1/lookup.php?i={id}
    ```
- **Random Meal**:
    ```sh
    GET https://www.themealdb.com/api/json/v1/1/random.php
    ```
- **Categories**:
    ```sh
    GET https://www.themealdb.com/api/json/v1/1/categories.php
    ```

