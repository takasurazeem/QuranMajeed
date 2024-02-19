//
//  MemoryDatastore.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 24/12/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import Foundation
import UIKit
import os

/// A simple in-memory data store that conforms to the `Datastore` protocol.
class MemoryDatastore: SyncDatastore {

    init(
        autoFlushDataStore: Bool = false
    ) {
        self.autoFlushDataStore = autoFlushDataStore
        self.data = [:]

        if autoFlushDataStore {
            observer = NotificationCenter.default.addObserver(
                forName: UIApplication.didEnterBackgroundNotification,
                object: nil,
                queue: nil
            ) { [weak self] _ in
                self?.flush()
            }
        }
    }

    func save<T: Codable>(_ data: T, forKey key: String) {
        lock.lock()
        self.data[key] = data
        lock.unlock()
    }

    func get<T: Codable>(forKey key: String) -> T? {
        lock.lock()
        defer { lock.unlock() }
        return self.data[key] as? T
    }

    func delete(forKey key: String) {
        lock.lock()
        self.data.removeValue(forKey: key)
        lock.unlock()
    }

    func flush() {
        lock.lock()
        self.data.removeAll(keepingCapacity: true)
        lock.unlock()
    }

    func autoFlush() {
        flush()
    }

    private var autoFlushDataStore: Bool
    private var data: [String: Codable]
    private let lock = OSAllocatedUnfairLock()
    private let logger = Logger(subsystem: "QuranMajeed", category: "MemoryDatastore")
    private var observer: NSObjectProtocol?
}
