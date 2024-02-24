//
//  MemoryDatastore.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 24/12/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import Foundation

/// A simple in-memory data store that conforms to the `Datastore` protocol.
class MemoryDatastore<T>: Datastore {
    private var data: [String: T] = [:]
    
    func save(_ data: T, forKey key: String) {
        self.data[key] = data
    }
    
    func load(forKey key: String) -> T? {
        return self.data[key]
    }
    
    func delete(forKey key: String) {
        self.data.removeValue(forKey: key)
    }
    
    func flush() {
        self.data.removeAll()
    }
}
