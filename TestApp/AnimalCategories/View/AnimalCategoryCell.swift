//
//  AnimalCategoryCell.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import SwiftUI

struct AnimalCategoryCell: View {
    
    var category: AnimalCategory
   
    var body: some View {
        
        ZStack {
            Color.white
                .cornerRadius(9)
            
            HStack {
                AsyncImage(url: URL(string: category.imageURLString)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFill()
                .frame(width: 114, height: 86)
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .padding([.leading, .trailing], 7)
                
                VStack(alignment: .leading) {
                    Text(category.title)
                        .padding(.top, 5)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                    
                    Text(category.description)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    if category.status == .paid {
                        HStack(spacing: 5) {
                            Image(systemName: "lock.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 14)
                                .foregroundColor(.blue)
                            
                            Text("Premium")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.blue)
                        }.padding(.bottom, 7)
                    }
                }
                
                Spacer()
            }
            
            if category.content.isEmpty {
                Color.black
                    .opacity(0.1)
                    .cornerRadius(9)
            }
            
        }.frame(height: 100)
    }
}
