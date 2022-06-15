//
//  AnimalCategory.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import Foundation

// MARK: -
// MARK: Animal category status
extension AnimalCategory {
    enum AnimalCategoryStatus: String, Codable {
        case paid, free
    }
}

// MARK: -
// MARK: Struct declaration
struct AnimalCategory: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let imageURLString: String
    let order: Int
    let status: AnimalCategoryStatus
    let content: [AnimalFact]
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURLString = "image"
        case order
        case status
        case content
    }
    
    init(title: String, description: String, imageURLString: String, order: Int, status: AnimalCategoryStatus, content: [AnimalFact]) {
        self.title = title
        self.description = description
        self.imageURLString = imageURLString
        self.order = order
        self.status = status
        self.content = content
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        imageURLString = try container.decode(String.self, forKey: .imageURLString)
        order = try container.decode(Int.self, forKey: .order)
        content = try container.decodeIfPresent([AnimalFact].self, forKey: .content) ?? []
        
        let statusString = try container.decode(String.self, forKey: .status)
        
        if let requiredStatus = AnimalCategoryStatus(rawValue: statusString) {
            status = requiredStatus
        } else {
            throw DecodingError.valueNotFound(AnimalCategoryStatus.self,
                                              .init(codingPath: [CodingKeys.status],
                                                    debugDescription: "value of type AnimalCategoryStatus not found"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(imageURLString, forKey: .imageURLString)
        try container.encode(order, forKey: .order)
        try container.encode(content, forKey: .content)
        try container.encode(status.rawValue, forKey: .status)
    }
}
