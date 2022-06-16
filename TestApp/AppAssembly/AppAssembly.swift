//
//  AppAssembly.swift
//  TestApp
//
//  Created by Артем Гавриленко on 16.06.2022.
//

import SwiftUI

final class ViewModelFactory {
    
    private lazy var animalsNetworkService: AnimalsNetworkService = {
        AnimalsNetworkService(networkService: networkService)
    }()
    
    private lazy var networkService: NetworkService = {
        NetworkService()
    }()
    
    func animalCategoriesViewModel() -> AnimalCategoriesViewModel {
        AnimalCategoriesViewModel(networkService: animalsNetworkService, viewModelFactory: self)
    }
    
    func animalFactsViewModel(facts: [AnimalFact]) -> AnimalFactsViewModel {
        AnimalFactsViewModel(facts: facts)
    }
}
