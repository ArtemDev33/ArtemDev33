//
//  TestAppApp.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import SwiftUI

@main
struct TestAppApp: App {
    
    let viewModelFactory = ViewModelFactory()
    
    var body: some Scene {
        WindowGroup {
            AnimalCategoriesView(viewModel: viewModelFactory.animalCategoriesViewModel())
        }
    }
}
