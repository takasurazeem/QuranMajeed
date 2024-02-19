//
//  MainQuizPreferencesRepository.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

class MainQuizPreferencesRepository: QuizPreferencesRepository {

    init(dataStore: SyncDatastore) {
        self.dataStore = dataStore
    }

    func save(quizPreferences: QuizPreferences) {
        
    }
    func get() -> QuizPreferences? {
        fatalError()
    }
    
    private let dataStore: SyncDatastore
}
