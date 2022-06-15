//
//  AnimalCategoriesView.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import SwiftUI

struct AnimalCategoriesView: View {
    
    @ObservedObject var viewModel = AnimalCategoriesViewModel(networkService: AnimalsNetworkService(networkService: NetworkService()))
    
    var body: some View {
        
        List {
            ForEach(viewModel.categories) { category in
                AnimalCategoryCell(category: category)
            }
        }
        .onAppear {
            viewModel.fetchCategories()
        }
    }
}

struct AnimalCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalCategoriesView()
    }
}
