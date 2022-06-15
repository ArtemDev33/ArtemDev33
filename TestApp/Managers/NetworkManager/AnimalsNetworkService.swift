//
//  AnimalsNetworkService.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import Foundation
import Combine
import UIKit

struct AnimalsNetworkService {
    
    let networkService: NetworkService
        
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getCategoriesList() -> AnyPublisher<[AnimalCategory], APIError> {
        networkService.execute(request: AnimalsEndpoint.categories.urlRequest)
    }
}
