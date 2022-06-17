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
                VStack {
                    
                    NavigationLink(destination: AnimalFactsView(viewModel: viewModel.animalFactsViewModel(facts: []))
                        .navigationTitle("Favourite")
                    ) {
                        HStack {
                            Spacer()
                            Text("Favourite")
                                .padding(.trailing, 32)
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                        }
                    }
                    
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
                                        showAD(categoryTitle: alertInfo?.title ?? "")
                                    })
                                case .unavailable:
                                    Button("OK", action: {})
                                }
                            }, message: { info in
                                Text(info.message)
                            })
                        
                        if viewModel.isLoading {
                            ZStack {
                                Color.black
                                    .opacity(0.2)
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(2)
                            }
                        }
                        
                    }.navigationTitle("Categories")
                }
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
            showAD = false
            viewModel.updateWatchedAdStatus(categoryTitle: categoryTitle)
        }
    }
    
    @ViewBuilder func row(category: Binding<AnimalCategory>) -> some View {
        
        switch category.wrappedValue.status {
        case .free:
            ZStack {
                AnimalCategoryCell(category: category.wrappedValue)
                NavigationLink(destination: AnimalFactsView(viewModel: viewModel.animalFactsViewModel(facts: category.wrappedValue.content))
                    .navigationTitle(category.wrappedValue.title)
                ) {
                    EmptyView()
                }
            }
            
        case .paid:
            ZStack {
                NavigationLink(
                    isActive: category.didWatchAD) {
                        AnimalFactsView(viewModel: viewModel.animalFactsViewModel(facts: category.wrappedValue.content))
                            .navigationTitle(category.wrappedValue.title)
                    } label: {
                        EmptyView()
                    }
                
                AnimalCategoryCell(category: category.wrappedValue)
                    .onTapGesture {
                        alertInfo = AlertInfo(title: category.wrappedValue.title, message: "Watch AD to continue!", useCase: .paid)
                        showAlert.toggle()
                    }
            }
            
        case .unavailable:
            AnimalCategoryCell(category: category.wrappedValue)
                .onTapGesture {
                    alertInfo = AlertInfo(title: category.wrappedValue.title, message: "Coming soon!", useCase: .unavailable)
                    showAlert.toggle()
                }
        }
    }
}
