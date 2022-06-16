//
//  SingleFactView.swift
//  TestApp
//
//  Created by Артем Гавриленко on 15.06.2022.
//

import SwiftUI
import Kingfisher

struct SingleFactView: View {
    
    var fact: AnimalFact
    var totalFactsCount: Int
    
    @Binding var tabSelection: Int
        
    private var isLastFact: Bool {
        tabSelection == totalFactsCount - 1
    }
    private var isFirstFact: Bool {
        tabSelection == 0
    }
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Color(uiColor: UIColor(red: 243/255, green: 242/255, blue: 247/255, alpha: 1))
                                
                VStack(alignment: .center, spacing: 10) {
                    
                    KFImage.url(URL(string: fact.imageURLString))
                        .placeholder { ProgressView() }
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width - 64, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                        .padding(.top, 16)
                    
                    Text(fact.fact)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .padding(.top, 5)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            self.tabSelection -= 1
                        } label: {
                            Image(systemName: "chevron.backward.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundColor(isFirstFact ? .gray : .black)
                        }.disabled(isFirstFact)
                        
                        Spacer()
                        
                        Button {
                            self.tabSelection += 1
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

//struct SingleFactView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleFactView(fact: AnimalFact(fact: "sdfjbsdkjnfkjsd", imageURLString: "lskdnglfngljfjg"))
//    }
//}
