//
//  AnimalCategoriesView.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import SwiftUI

struct AnimalCategoriesView: View {
    
    @ObservedObject var viewModel: AnimalCategoriesViewModel
    
    @State var showAD = false
    @State var showAlert = false
    @State var alertInfo: AlertInfo?
                
    var body: some View {
        
        ZStack {
            NavigationView {
                ZStack {
                    List {
                        ForEach($viewModel.categories) { category in
                            row(category: category)
                        }
                    }
                    
                    .alert(
                        alertInfo?.title ?? "",
                        isPresented: $showAlert,
                        presenting: alertInfo,
                        actions: { info in
                            switch info.useCase {
                            case .paid:
                                Button("Cancel", role: .cancel, action: {})
                                Button("Watch Ad", action: {
                                    self.showAD(categoryTitle: alertInfo?.title ?? "")
                                })
                            case .unavailable:
                                Button("OK", action: {})
                            }
                        })
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }.navigationTitle("Categories")
            }
            
            if showAD {
                ZStack {
                    Color.black
                        .opacity(0.7)
                        .ignoresSafeArea()
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(2.7)
                }
            }
        }
        .onAppear {
            viewModel.fetchCategories()
        }
    }
}

// MARK: - Private
private extension AnimalCategoriesView {
    
    func showAD(categoryTitle: String) {
        showAD = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showAD = false
            viewModel.updateWatchedAdStatus(categoryTitle: categoryTitle)
        }
    }
    
    @ViewBuilder func row(category: Binding<AnimalCategory>) -> some View {
        
        switch category.wrappedValue.status {
        case .free:
            ZStack {
                AnimalCategoryCell(category: category.wrappedValue)
                NavigationLink(destination: AnimalFactsView(viewModel: AnimalFactsViewModel(facts: category.wrappedValue.content))
                    .navigationTitle(category.wrappedValue.title)
                ) {
                    EmptyView()
                }
            }
            
        case .paid:
            ZStack {
                NavigationLink(
                    isActive: category.paid) {
                        AnimalFactsView(viewModel: viewModel.animalFactsViewModel(facts: category.wrappedValue.content))
                            .navigationTitle(category.wrappedValue.title)
                    } label: {
                        EmptyView()
                    }
                
                AnimalCategoryCell(category: category.wrappedValue)
                    .onTapGesture {
                        self.alertInfo = AlertInfo(title: category.wrappedValue.title, useCase: .paid)
                        showAlert.toggle()
                    }
            }
            
        case .unavailable:
            AnimalCategoryCell(category: category.wrappedValue)
                .onTapGesture {
                    self.alertInfo = AlertInfo(title: category.wrappedValue.title, useCase: .unavailable)
                    showAlert.toggle()
                }
        }
    }
}

//struct AnimalCategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimalCategoriesView()
//    }
//}
