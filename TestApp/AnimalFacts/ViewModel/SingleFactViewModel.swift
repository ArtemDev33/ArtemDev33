//
//  SingleFactViewModel.swift
//  TestApp
//
//  Created by Артем Гавриленко on 16.06.2022.
//

import Kingfisher
import UIKit

final class SingleFactViewModel: ObservableObject {
    
    var fact: AnimalFact
    var totalFactsCount: Int
    var factsLocation: FactsLocationState
    var loadedImage: UIImage?
    
    private var storageManager: StorageManager
    
    init(fact: AnimalFact, totalFactsCount: Int, factsLocation: FactsLocationState, storageManager: StorageManager) {
        self.fact = fact
        self.totalFactsCount = totalFactsCount
        self.factsLocation = factsLocation
        self.storageManager = storageManager
        
        if factsLocation == .local {
            loadedImage = try? storageManager.readImage(named: fact.id)
        }
    }
    
    func addFactToDB() {
        if let requiredImage = loadedImage {
            storageManager.create(fact: fact, image: requiredImage)
        }
    }
}
