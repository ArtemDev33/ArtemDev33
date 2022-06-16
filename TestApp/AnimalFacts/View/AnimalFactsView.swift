//
//  AnimalFactsView.swift
//  TestApp
//
//  Created by Артем Гавриленко on 15.06.2022.
//

import SwiftUI

struct AnimalFactsView: View {
    
    @StateObject var viewModel: AnimalFactsViewModel
    @State private var tabSelection = 0
        
    var body: some View {
        VStack {
            TabView(selection: $tabSelection) {
                ForEach(viewModel.facts.indices, id: \.self) { index in
                    SingleFactView(
                        fact: viewModel.facts[index],
                        totalFactsCount: viewModel.facts.count,
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


struct AnimalFactsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalFactsView(viewModel: AnimalFactsViewModel(facts: [
            AnimalFact(fact: "sfgjnfdnjlg", imageURLString: "fknsjgnksfng"),
            AnimalFact(fact: "sfgjnfdnjlg", imageURLString: "fknsjgnksfng")
        ]))
    }
}
