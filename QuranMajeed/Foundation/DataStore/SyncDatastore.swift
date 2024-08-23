//
//  Datastore.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 24/12/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import Foundation

/// A protocol defining the basic operations for a data store.
protocol SyncDatastore {
    /// Save data to the data store for a given key.
    /// - Parameters:
    ///   - data: The data to be saved.
    ///   - key: The key associated with the data.
    func save<T: Codable>(_ data: T, forKey key: String)

    /// Load data from the data store for a given key.
    /// - Parameter key: The key associated with the data to be loaded.
    /// - Returns: The loaded data, or `nil` if no data is found for the given key.
    func get<T: Codable>(forKey key: String) -> T?

    /// Delete data from the data store for a given key.
    /// - Parameter key: The key associated with the data to be deleted.
    func delete(forKey key: String)

    /// Flush all data from the data store.
    func flush()
}
