//
//  TwoLevelDatastore.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 24/12/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import Foundation

/// A two-level data store implementing both primary and secondary data stores.
class TwoLevelDatastore<T: Codable>: Datastore {
    private let memoryDatastore: MemoryDatastore<T>
    private let fileDatastore: FileDatastore<T>
    
    /// Initializes a `TwoLevelDatastore` with a specific purpose.
    /// - Parameter purpose: The purpose or context for the secondary data store.
    init(purpose: String) {
        self.memoryDatastore = MemoryDatastore()
        self.fileDatastore = FileDatastore(purpose: purpose)
    }
    
    // MARK: - Implementation of Datastore methods
    
    func save(_ data: T, forKey key: String) {
        // Save to memory data store
        memoryDatastore.save(data, forKey: key)
        
        // Save to file data store
        fileDatastore.save(data, forKey: key)
    }
    
    func load(forKey key: String) -> T? {
        // Try to load from memory data store first
        if let loadedData = memoryDatastore.load(forKey: key) {
            return loadedData
        } else {
            // If not found in memory, try to load from file data store
            return fileDatastore.load(forKey: key)
        }
    }
    
    func delete(forKey key: String) {
        // Delete from both memory and file data stores
        memoryDatastore.delete(forKey: key)
        fileDatastore.delete(forKey: key)
    }
    
    func flush() {
        memoryDatastore.flush()
        fileDatastore.flush()
    }
}

