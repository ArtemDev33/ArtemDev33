//
//  AnimalsEndpoint.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import Foundation

enum AnimalsEndpoint {
    case categories
}

extension AnimalsEndpoint {
    
    var urlRequest: URLRequest {
        switch self {
        case .categories:
            guard let url = URL(string: "https://drive.google.com/uc?export=download&id=12L7OflAsIxPOF47ssRdKyjXoWbUrq4V5") else {
                preconditionFailure("Invalid URL format")
            }
            
            let request = URLRequest(url: url)
            return request
        }
    }
}
