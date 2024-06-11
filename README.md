# Meals Recipe Challenge 
The SwiftUI Meal App is a simple application that displays meal categories and their respective meals. Users can navigate through different meal categories such as Breakfast, Lunch, Dinner, and Dessert, and view details of each meal including its ingredients and instructions.

## Features
- Display meal categories in a tab view
- Fetch meals from an API based on selected category.
- Show meal details including image, instructions, and ingredients.
- Handle default values for missing or null data from the API.

## Requirements
- macOS with Xcode installed.
- Swift 5.0 or later.
- An active internet connection to fetch meal data from the API.

## Installation
1. Clone the Repository

   ```
   git clone https://github.com/pranjalpc99/Fetch-Challenge-iOS.git
   cd Fetch-Challenge-iOS
   ```
2. Open the Project in Xcode
   Double-click on MealApp.xcodeproj to open the project in Xcode.

## Building and Running the App
1. Build the Project
   Make sure you have selected the correct target device or simulator, then click on the build button (or press `Cmd + B`) to build the project.

2. Run the Project
   Click on the run button (or press `Cmd + R`) to run the app on the selected device or simulator.

## Project Structure
- Models
  - `MealsResponse`: Handles the response from the API for Meals.
  - `Meal`: Contains properties for meal of a particular category.
  - `MealDetailsResponse`: Handles the response from the API for Meal Details.
  - `MealDetails`: Contains properties for meal details, including ingredients and measures.
  - `Ingredient`: Represents an ingredient and its measure.
 
- ViewModels
  - `MealViewModel`: Manages the fetching of meals of same category from the API. 
  - `MealDetailsViewModel`: Manages the fetching of meals and meal details from the API.
 
- Views
  - `MealsHomeView`: Main view containing the TabView for different meal categories.
  - `CategoryMealsView`: Displays meals for a selected category.
  - `MealDetailView`: Displays details of a selected meal.
  - `HeaderView`, `RecipeImageView`, `RecipeDetailsView`, `IngredientsView`: Subviews for displaying meal details.
 
## Usage
1. Navigating Through Categories
   Open the app and navigate through different meal categories using the bottom tab view. Each tab represents a meal category such as Dessert, Breakfast, Chicken, and Vegetarian.

2. Viewing Meal Details
   Tap on any meal from the list to view its details, including the meal image, instructions, and ingredients.

## License
This project is licensed under the MIT License. 

