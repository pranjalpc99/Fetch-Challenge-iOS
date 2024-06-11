//
//  MealDetailView.swift
//  fetchcodingchallenge
//
//  Created by Pranjal Chaudhari on 10/06/24.
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    @ObservedObject var viewModel = MealDetailsViewModel()
    
    var body: some View {
        VStack {
                    if let mealDetails = viewModel.mealDetails {
                        HeaderView(meal: mealDetails)
                        ScrollView {
                            RecipeImageView(imageUrl: mealDetails.strMealThumb)
                            RecipeDetailsView(mealDetails: mealDetails)
                            IngredientsView(ingredients: mealDetails.ingredients)
                        }
                    } else {
                        Text("Loading...")
                            .font(.title)
                            .padding()
                    }
                }
                .navigationBarTitle("", displayMode: .inline) // Empty title
                .navigationBarHidden(false) // Hide the navigation bar title
                .navigationBarBackButtonHidden(false)
                .onAppear {
                    viewModel.fetchMealDetails(mealID: meal.idMeal)
                }
    }
}

struct HeaderView: View {
    let meal: MealDetails
    var body: some View {
        HStack(alignment: .center) {
            Text(meal.strMeal)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}


struct RecipeImageView: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
        } placeholder: {
            ProgressView()
                .padding()
        }
        .frame(height: 200) // Adjust height as needed
    }
}

struct RecipeDetailsView: View {
    let mealDetails: MealDetails
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(mealDetails.strInstructions ?? "No instructions")
                .padding(.vertical)
            
            Divider()
                .frame(height: 1.0)
                .background(Color.black)
            
            HStack {
                VStack {
                    Text("Ingredients")
                    Text("\(mealDetails.ingredients.count) items")
                }
                
                Spacer()
                Divider()
                    .frame(width: 1.0, height: 40)
                    .background(Color.black)
                Spacer()
                
                VStack {
                    Text("Origin")
                    Text(mealDetails.strArea ?? "Nil")
                }
                
                Spacer()
                Divider()
                    .frame(width: 1.0, height: 40)
                    .background(Color.black)
                Spacer()
                
                VStack {
                    Text("Category")
                    Text(mealDetails.strCategory)
                }
            }
            .padding(.horizontal)
            Divider()
                .frame(height: 1.0)
                .background(Color.black)
        }
        .padding()
    }
}

struct IngredientsView: View {
    let ingredients: [Ingredient]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            
            ForEach(ingredients.indices, id: \.self) { index in
                let ingredient = ingredients[index]
                HStack {
                    Text(ingredient.name)
                    Spacer()
                    Text(ingredient.measure)
                }
                .padding(.vertical, 4)
                if index < ingredients.count - 1 {
                    Divider()
                }
            }
        }
        .padding()
        .background(Color("CustomOrange"))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom)
    }
}


#Preview {
    MealDetailView(meal: Meal(idMeal: "0", strMeal: "Meal Name", strMealThumb: "Meal Thumb"))
}
