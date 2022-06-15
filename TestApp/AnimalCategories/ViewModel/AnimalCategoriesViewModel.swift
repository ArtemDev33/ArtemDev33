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
    
    var cancellables = Set<AnyCancellable>()
    
    init(networkService: AnimalsNetworkService) {
        self.networkService = networkService
    }
    
    @Published var categories = [AnimalCategory]()
    
    func fetchCategories() {
        let cancellable = networkService.getCategoriesList()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }) { categories in
                self.categories = categories.sorted(by: { $0.order < $1.order })
        }
        cancellables.insert(cancellable)
    }
}
