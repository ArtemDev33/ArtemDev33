//
//  StorageManager.swift
//  TestApp
//
//  Created by Артем Гавриленко on 16.06.2022.
//

import Foundation
import RealmSwift
import UIKit

// MARK: - Errors
extension StorageManager {
    enum Error: String, Swift.Error {
        case fileNotExists = "file doesn't exist"
        case invalidDirectory = "invalid directory"
        case writingFailed = "writing failed"
        case readingFailed = "reading failed"
        case invalidURL = "invalid url"
    }
}

// MARK: - Class declaration
final class StorageManager {
    
    private let fileManager: FileManager
    private var factsResults: Results<AnimalFactDB>
    
    var facts: [AnimalFact] {
        factsResults.map(AnimalFact.init)
    }
    
    init(realm: Realm, fileManager: FileManager = .default) {
        factsResults = realm.objects(AnimalFactDB.self)
        self.fileManager = fileManager
    }
    
    func create(fact: AnimalFact, image: UIImage) {
        do {
            let realm = try Realm()

            let factDB = AnimalFactDB()
            factDB.id = fact.id
            factDB.fact = fact.fact
            
            try save(fileNamed: fact.id, data: image.jpegData(compressionQuality: 1.0)!)

            try realm.write {
                realm.add(factDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func readImage(named: String) throws -> UIImage? {
        guard let url = url(forFileNamed: named) else {
            throw Error.invalidDirectory
        }
        guard fileManager.fileExists(atPath: url.path) else {
            throw Error.fileNotExists
        }
        
        return UIImage(contentsOfFile: url.path)
    }
}

// MARK: - Private
private extension StorageManager {
            
    func save(fileNamed: String, data: Data) throws {
        guard let url = url(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }

        do {
            try data.write(to: url, options: .atomic)
        } catch {
            throw Error.writingFailed
        }
    }

    func url(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
}
