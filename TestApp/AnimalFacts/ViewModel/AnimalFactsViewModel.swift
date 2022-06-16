//
//  AnimalFactsViewModel.swift
//  TestApp
//
//  Created by Артем Гавриленко on 15.06.2022.
//

import SwiftUI
import Combine

final class AnimalFactsViewModel: ObservableObject {
    
    @Published var facts: [AnimalFact]
            
    init(facts: [AnimalFact]) {
        self.facts = facts
    }
}
