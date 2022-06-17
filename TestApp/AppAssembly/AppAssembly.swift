//
//  AppAssembly.swift
//  TestApp
//
//  Created by Артем Гавриленко on 16.06.2022.
//

import SwiftUI
import RealmSwift

final class ViewModelFactory {
    
    private lazy var storageManager: StorageManager = {
        do {
            let realm = try Realm()
            return StorageManager(realm: realm)
        } catch let error {
            fatalError("Failed to open Realm. Error: \(error.localizedDescription)")
        }
    }()
    
    private lazy var animalsNetworkService: AnimalsNetworkService = {
        AnimalsNetworkService(networkService: networkService)
    }()
    
    private lazy var networkService: NetworkService = {
        NetworkService()
    }()
    
    func animalCategoriesViewModel() -> AnimalCategoriesViewModel {
        AnimalCategoriesViewModel(networkService: animalsNetworkService, viewModelFactory: self)
    }
    
    func animalFactsViewModel(facts: [AnimalFact] = []) -> AnimalFactsViewModel {
        if facts.isEmpty {
            return AnimalFactsViewModel(storageManager: storageManager, viewModelFactory: self)
        } else {
            return AnimalFactsViewModel(facts: facts, storageManager: storageManager, viewModelFactory: self)
        }
    }
    
    func singleFactViewModel(fact: AnimalFact, totalFactsCount: Int, factsLocation: FactsLocationState) -> SingleFactViewModel {
        SingleFactViewModel(
            fact: fact,
            totalFactsCount: totalFactsCount,
            factsLocation: factsLocation,
            storageManager: storageManager)
    }
}
