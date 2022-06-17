//
//  AnimalFactDB.swift
//  TestApp
//
//  Created by Артем Гавриленко on 16.06.2022.
//

import Foundation
import RealmSwift

class AnimalFactDB: Object {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var fact = ""
}
