//
//  MainQuizPreferencesRepository.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import Foundation

class MainQuizPreferencesRepository: QuizPreferencesRepository {

    init(dataStore: QuizPreferencesDataStore) {
        self.dataStore = dataStore
    }

    func save(quizPreferences: QuizPreferences) {
        dataStore.save(quizPreferences: quizPreferences)
    }
    
    func get() -> QuizPreferences? {
        dataStore.get()
    }

    private let dataStore: QuizPreferencesDataStore
}
