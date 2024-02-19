//
//  MainQuizPreferencesDataStore.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

class MainQuizPreferencesDataStore: QuizPreferencesDataStore {

    init(dataStore: any SyncDatastore) {
        self.dataStore = dataStore
    }

    func save(quizPreferences: QuizPreferences) {
        dataStore.save(quizPreferences, forKey: storageKey)
    }
    
    func get() -> QuizPreferences? {
        dataStore.get(forKey: storageKey)
    }
    
    // MARK: - Properties
    private let dataStore: any SyncDatastore
    private let storageKey = "quizPreferences"
}
