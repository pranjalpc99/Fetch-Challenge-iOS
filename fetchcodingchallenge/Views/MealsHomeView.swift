//
//  MealsHomeView.swift
//  fetchcodingchallenge
//
//  Created by Pranjal Chaudhari on 11/06/24.
//

import SwiftUI
import Combine

struct MealsHomeView: View {
    @ObservedObject var viewModel = MealViewModel()
    
    var body: some View {
        TabView {
            CategoryMealsView(category: "Dessert", meals: viewModel.mealsDessert, viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "moon.stars.fill")
                            Text("Dessert")
                        }
                    
                    CategoryMealsView(category: "Breakfast",meals: viewModel.mealsBreakfast, viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "sunrise.fill")
                            Text("Breakfast")
                        }
                    
                    CategoryMealsView(category: "Chicken", meals: viewModel.mealsChicken,viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "fork.knife")
                            Text("Chicken")
                        }
                    
                    CategoryMealsView(category: "Vegetarian",meals: viewModel.mealsVegan, viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "carrot")
                            Text("Vegetarian")
                        }
                }
    }
}

struct CategoryMealsView: View {
    let category: String
    let meals: [Meal]
    @ObservedObject var viewModel: MealViewModel
    
    var body: some View {
        NavigationView {
            List(meals) { meal in
                
                    HStack{
                        if let url = URL(string: meal.strMealThumb) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        }
                        Text(meal.strMeal)
                            .font(.headline)
                            .padding()
                    }.background(
                        NavigationLink("",destination: MealDetailView(meal: meal)).opacity(0)
                    )
                
            }
            .navigationBarTitle(category, displayMode: .large)
            .onAppear {
                viewModel.fetchMealsByCategory(category: category)
            }
        }
    }
}

struct AsyncImage<Content: View, Placeholder: View>: View{
    @StateObject private var loader: ImageLoader
        private let content: (Image) -> Content
        private let placeholder: Placeholder
        
        init(
            url: URL?,
            @ViewBuilder content: @escaping (Image) -> Content,
            @ViewBuilder placeholder: () -> Placeholder
        ) {
            _loader = StateObject(wrappedValue: ImageLoader(url: url))
            self.content = content
            self.placeholder = placeholder()
        }
        
        var body: some View {
            contentBody
                .onAppear(perform: loader.load)
        }
        
        private var contentBody: some View {
            Group {
                if let image = loader.image {
                    content(image)
                } else {
                    placeholder
                }
            }
        }
}

class ImageLoader: ObservableObject {
    @Published var image: Image?
    private let url: URL?
    private var cancellable: AnyCancellable?
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() {
        guard let url = url else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { Image(uiImage: UIImage(data: $0.data) ?? UIImage()) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
}

#Preview {
    MealsHomeView()
}
