//
//  APISession.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import Foundation
import Combine
import SwiftUI

struct NetworkService {
 
    func execute<T>(request: URLRequest, queue: DispatchQueue = .main) -> AnyPublisher<T, APIError> where T: Decodable {
                
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                guard (200...299).contains(response.statusCode) else {
                    throw APIError.httpError(response.statusCode)
                }
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw APIError.decodingError
                }
            }
            .mapError { error in
                error as? APIError ?? .unknown
            }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
