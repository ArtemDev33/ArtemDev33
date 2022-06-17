//
//  AnimalFact.swift
//  TestApp
//
//  Created by Артем Гавриленко on 14.06.2022.
//

import Foundation

struct AnimalFact: Identifiable, Codable {
    let id: String
    let fact: String
    let imageURLString: String
    
    enum CodingKeys: String, CodingKey {
        case fact
        case imageURLString = "image"
        case id
    }
    
    init(fact: String, imageURLString: String) {
        self.id = UUID().uuidString
        self.fact = fact
        self.imageURLString = imageURLString
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        fact = try container.decode(String.self, forKey: .fact)
        imageURLString = try container.decode(String.self, forKey: .imageURLString)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(fact, forKey: .fact)
        try container.encode(imageURLString, forKey: .imageURLString)
    }
}

// MARK: - Realm object init
extension AnimalFact {
    init(animalFact: AnimalFactDB) {
        id = animalFact.id
        fact = animalFact.fact
        imageURLString = ""
    }
}
