//
//  FileDatastore.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 24/12/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import Foundation

/// A file-based data store that conforms to the `Datastore` protocol and supports Codable data.
class FileDatastore: SyncDatastore {
    private let fileManager = FileManager.default
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    /// Additional property indicating the purpose of the file data store.
    var purpose: String
    
    /// Initializes a `FileDatastore` with a specific purpose.
    /// - Parameter purpose: The purpose or context for the file data store.
    init(purpose: String) {
        self.purpose = purpose
    }
    
    func save<T: Codable>(_ data: T, forKey key: String) {
        let fileURL = getFileURL(forKey: key)
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: fileURL)
        } catch {
            print("Error saving data to file: \(error.localizedDescription)")
        }
    }
    
    func get<T: Codable>(forKey key: String) -> T? {
        let fileURL = getFileURL(forKey: key)
        do {
            // Check if file exists, if not, create an empty file.
            if !fileManager.fileExists(atPath: fileURL.path) {
                try saveEmptyFile(at: fileURL)
            }
            
            let data = try Data(contentsOf: fileURL)
            
            // If data is empty or only contains an empty JSON object
            if data.isEmpty || data == "{}".data(using: .utf8) {
                return nil
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error loading data from file: \(error.localizedDescription)")
            return nil
        }
    }
    
    func delete(forKey key: String) {
        let fileURL = getFileURL(forKey: key)
        try? fileManager.removeItem(at: fileURL)
    }
    
    func flush() {
        do {
            let files = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            for file in files {
                try fileManager.removeItem(at: file)
            }
        } catch {
            print("Error flushing files: \(error.localizedDescription)")
        }
    }
    
    private func getFileURL(forKey key: String) -> URL {
        return documentsDirectory.appendingPathComponent("\(key)_\(purpose).json")
    }
    
    private func saveEmptyFile(at url: URL) throws {
        // Save an empty JSON object to avoid the file not found error
        let emptyData = "{}".data(using: .utf8)!
        try emptyData.write(to: url)
    }
}
