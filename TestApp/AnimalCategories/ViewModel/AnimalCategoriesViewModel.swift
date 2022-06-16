//
//  AnimalCategoriesViewModel.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import SwiftUI
import Combine

final class AnimalCategoriesViewModel: ObservableObject {
    
    var networkService: AnimalsNetworkService
    var viewModelFactory: ViewModelFactory
    
    var cancellables = Set<AnyCancellable>()
    
    init(networkService: AnimalsNetworkService, viewModelFactory: ViewModelFactory) {
        self.networkService = networkService
        self.viewModelFactory = viewModelFactory
    }
    
    @Published var categories = [AnimalCategory]()
    @Published var isLoading = false
    
    func fetchCategories() {
        isLoading = true
        
        networkService.getCategoriesList()
            .sink(receiveCompletion: { [self] result in
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }) { categories in
                self.categories = categories.sorted(by: { $0.order < $1.order })
            }.store(in: &cancellables)
    }
    
    func animalFactsViewModel(facts: [AnimalFact]) -> AnimalFactsViewModel {
        viewModelFactory.animalFactsViewModel(facts: facts)
    }
    
    func updateWatchedAdStatus(categoryTitle: String) {
        if let index = categories.firstIndex(where: { $0.title == categoryTitle }) {
            categories[index].paid = true
        }
    }
}
