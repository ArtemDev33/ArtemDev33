//
//  AnimalFactsViewModel.swift
//  TestApp
//
//  Created by Артем Гавриленко on 15.06.2022.
//

import SwiftUI
import Combine

final class AnimalFactsViewModel: ObservableObject {
    
    private let storageManager: StorageManager
    private let viewModelFactory: ViewModelFactory
    
    let factsLocation: FactsLocationState
    
    @Published var facts: [AnimalFact]
            
    init(storageManager: StorageManager, viewModelFactory: ViewModelFactory) {
        self.storageManager = storageManager
        self.viewModelFactory = viewModelFactory
        facts = storageManager.facts
        factsLocation = .local
    }
    
    init(facts: [AnimalFact], storageManager: StorageManager, viewModelFactory: ViewModelFactory) {
        self.facts = facts
        self.storageManager = storageManager
        self.viewModelFactory = viewModelFactory
        factsLocation = .remote
    }
    
    func singleFactViewModel(fact: AnimalFact) -> SingleFactViewModel {
        viewModelFactory.singleFactViewModel(fact: fact, totalFactsCount: facts.count, factsLocation: factsLocation)
    }
}
