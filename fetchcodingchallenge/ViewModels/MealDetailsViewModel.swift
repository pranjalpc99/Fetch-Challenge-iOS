//
//  MealDetailsViewModel.swift
//  fetchcodingchallenge
//
//  Created by Pranjal Chaudhari on 11/06/24.
//

import Foundation
import Combine

class MealDetailsViewModel: ObservableObject {
    @Published var meals: [MealDetails] = []
    @Published var mealDetails: MealDetails?
    private var cancellables = Set<AnyCancellable>()
    let apiCalls = APICalls.apiCalls
    
    func fetchMealDetails(mealID: String) {
        //print("Get for: \(mealID)")
        guard let url = URL(string: "\(apiCalls.apiUrl)1/lookup.php?i="+mealID) else {
            print("Invalid url")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: MealsDetailsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Successfully fetched data")
                case .failure(let error):
                    print("Error fetching meals: \(error)")
                }
            }, receiveValue: {[weak self] reponse in
                self?.meals = reponse.meals
                self?.mealDetails = reponse.meals[0]
                //print("Fetched meals: \(reponse.meals)")
            })
            .store(in: &cancellables)
    }
}
