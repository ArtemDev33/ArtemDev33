//
//  AnimalFactsView.swift
//  TestApp
//
//  Created by Артем Гавриленко on 15.06.2022.
//

import SwiftUI

struct AnimalFactsView: View {
    
    @ObservedObject var viewModel: AnimalFactsViewModel
    @State private var tabSelection = 0
        
    var body: some View {
        
        if viewModel.factsLocation == .local, viewModel.facts.isEmpty {
            VStack(spacing: 16) {
                Image(systemName: "sparkle.magnifyingglass")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("No facts are saved yet. Browse categories to do it! ")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 20)
            }
        } else {
            VStack {
                TabView(selection: $tabSelection) {
                    ForEach(viewModel.facts.indices, id: \.self) { index in
                        SingleFactView(
                            viewModel: viewModel.singleFactViewModel(fact: viewModel.facts[index]),
                            tabSelection: $tabSelection)
                        .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 580)
                
                Spacer()
                
            }.padding(.top, 5)
        }
    }
}
