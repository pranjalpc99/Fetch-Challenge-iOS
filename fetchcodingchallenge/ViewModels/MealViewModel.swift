//
//  MealViewModel.swift
//  fetchcodingchallenge
//
//  Created by Pranjal Chaudhari on 07/06/24.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealsDessert: [Meal] = []
    @Published var mealsChicken: [Meal] = []
    @Published var mealsBreakfast: [Meal] = []
    @Published var mealsVegan: [Meal] = []
    private var cancellables = Set<AnyCancellable>()
    let apiCalls = APICalls.apiCalls
    
    func fetchMeals() {
        guard let url = URL(string: "\(apiCalls.apiUrl)1/filter.php?c=Dessert") else {
            print("Invalid url")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MealsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Successfully fetched data")
                case .failure(let error):
                    print("Error fetching meals: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.meals = response.meals
                //print("Fetched meals: \(response.meals)")
            })
            .store(in: &cancellables)
    }
    
    func fetchMealsByCategory(category: String) {
            //print("Fetching meals for category: \(category)")
            guard let url = URL(string: "\(apiCalls.apiUrl)1/filter.php?c=\(category)") else {
                print("Invalid url")
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: MealsResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Successfully fetched data")
                    case .failure(let error):
                        print("Error fetching meals: \(error)")
                    }
                }, receiveValue: { [weak self] response in
                    self?.meals = response.meals
                    switch category {
                    case "Breakfast": self?.mealsBreakfast = response.meals
                    case "Dessert": self?.mealsDessert = response.meals
                    case "Chicken": self?.mealsChicken = response.meals
                    case "Vegetarian": self?.mealsVegan = response.meals
                    default: self?.mealsDessert = response.meals
                    }
                    //print("Fetched meals: \(response.meals)")
                })
                .store(in: &cancellables)
        }
}
