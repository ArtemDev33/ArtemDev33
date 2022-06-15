//
//  APIError.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
