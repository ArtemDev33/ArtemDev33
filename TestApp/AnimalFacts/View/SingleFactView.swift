//
//  SingleFactView.swift
//  TestApp
//
//  Created by Артем Гавриленко on 15.06.2022.
//

import SwiftUI
import Kingfisher

struct SingleFactView: View {
            
    @ObservedObject var viewModel: SingleFactViewModel
    @Binding var tabSelection: Int
    
    @State var enableSaveButton = false
        
    private var isLastFact: Bool {
        tabSelection == viewModel.totalFactsCount - 1
    }
    private var isFirstFact: Bool {
        tabSelection == 0
    }
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                
                Color.lightGray
                                
                VStack(alignment: .center, spacing: 10) {

                    imageView(geometry: geo)
                    
                    Text(viewModel.fact.fact)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .padding(.top, 5)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            tabSelection -= 1
                        } label: {
                            Image(systemName: "chevron.backward.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundColor(isFirstFact ? .gray : .black)
                        }.disabled(isFirstFact)
                        
                        Spacer()
                        
                        if viewModel.factsLocation == .remote {
                            Button { [weak viewModel] in
                                viewModel?.addFactToDB()
                            } label: {
                                Text("Save")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                            }
                            .disabled(!enableSaveButton)
                            
                            Spacer()
                        }
                        
                        Button {
                            tabSelection += 1
                        } label: {
                            Image(systemName: "chevron.forward.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundColor(isLastFact ? .gray : .black)
                        }.disabled(isLastFact)
                        
                    }.padding(.bottom, 50)
                    .padding([.leading, .trailing], 16)
                    
                }.padding([.leading, .trailing], 16)
            }
            .frame(width: geo.size.width - 32)
            .cornerRadius(9)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
    }
}

// MARK: - Private
private extension SingleFactView {
    
    @ViewBuilder func imageView(geometry: GeometryProxy) -> some View {
        
        if viewModel.factsLocation == .remote {
            KFImage.url(URL(string: viewModel.fact.imageURLString))
                .placeholder { ProgressView() }
                .onSuccess { [weak viewModel] result in
                    viewModel?.loadedImage = result.image
                    enableSaveButton = true
                }
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width - 64, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .padding(.top, 16)
        } else if let image = viewModel.loadedImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width - 64, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .padding(.top, 16)
        } else {
            EmptyView()
        }
    }
}
